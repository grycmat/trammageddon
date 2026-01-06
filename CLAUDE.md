# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Trammageddon is a Flutter mobile application for reporting and tracking tram (public transport) incidents in Kraków, Poland. The application features a distinct brutalist/distress design aesthetic using red and black color schemes with an industrial, "wanted poster" visual style. Application package: `com.gigapingu.trammageddon`.

## Development Commands

### Flutter Commands
- `flutter run` - Run the app in debug mode
- `flutter run --release` - Run the app in release mode
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run a single test file
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies
- `flutter analyze` - Run static analysis
- `flutter clean` - Clean build artifacts

### Android-Specific
- `cd android && gradlew.bat clean` - Clean Android build (Windows)
- `cd android && gradlew.bat assembleDebug` - Build debug APK via Gradle

## Architecture

### Project Structure
- `lib/main.dart` - Entry point with GetIt service registration and Firebase initialization
- `lib/layout/` - Layout wrappers
  - `scaffold_with_nav.dart` - Scaffold wrapper providing persistent bottom navigation
- `lib/screens/` - Screen-level widgets organized by feature
  - `login/` - Login/register screen with Firebase Auth
  - `add_incident/` - Incident reporting screen and related widgets
  - `dashboard/` - Dashboard screen with data visualization
  - `hall_of_defame/` - Rankings screen with detailed entries
  - `settings/` - User settings screen
  - `line_details/` - Line details screen with incident list
- `lib/widgets/` - Reusable UI components
- `lib/theme/` - Theme and styling
  - `theme.dart` - Defines `AppTheme` with dark and light themes
  - `colors.dart` - Centralized color palette in `AppColors`
- `lib/routing/` - Navigation configuration
  - `app_router.dart` - GoRouter setup with auth redirects and ShellRoute
  - `route_names.dart` - Centralized route path constants
- `lib/model/` - Data models (RankingItem, Incident, User, Category, City, TramLine)
- `lib/services/` - Business logic services
  - `auth.service.dart` - Firebase Auth + SharedPreferences
  - `incident.service.dart` - Firestore incident operations
  - `preferences.service.dart` - SharedPreferences wrapper
- `lib/data/` - Static lookup data (categories, tram_lines, cities)

### State Management
The app uses a multi-layered approach:
- **GetIt (Service Locator)**: Singleton pattern for global services
  - Services registered in `main.dart` with async dependency chain
  - Access via `getIt.get<ServiceName>()`
- **ChangeNotifier**: `AuthService` extends `ChangeNotifier` to trigger route refreshes
- **Local State**: `StatefulWidget` with `setState()` for forms and UI state
- **SharedPreferences**: User data persistence (username, userId, theme)

### Service Initialization Pattern
```dart
final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(...);
  getIt.registerSingleton<IncidentService>(IncidentService());
  getIt.registerSingletonAsync<PreferencesService>(() => PreferencesService.init());
  getIt.registerSingletonAsync(
    () async => AuthService.init(getIt.get<PreferencesService>()),
    dependsOn: [PreferencesService],
  );
  await getIt.allReady();
  runApp(Trammageddon());
}
```

### Routing System
The app uses `go_router` with authentication guards:
- `AuthService` extends `ChangeNotifier` and triggers route refreshes on auth state changes
- Initial route is `/login` with redirect to `/` if authenticated
- Uses `ShellRoute` pattern for persistent bottom navigation
- Routes: `/login`, `/` (home), `/add-incident`, `/hall-of-defame`, `/settings`, `/line-details`

### Theme System
The app uses a custom brutalist design with:
- Two font families: `Oswald` (headers) and `ChivoMono` (body/labels)
- Zero border radius (sharp, angular UI)
- Heavy borders (1-4px depending on element)
- High contrast color scheme with red accents
- Both dark mode (default) and light mode support
- ALL text in uppercase for emphasis and impact

### Backend Integration
Firebase services:
- **Firebase Auth**: Email/password authentication
- **Cloud Firestore**: Incident data storage
- Firebase credentials stored in `lib/firebase_options.dart`

### Firestore Data Structure
```
incidents/
├── {docId}
│   ├── line: "1"
│   ├── vehicleNumber: "optional"
│   ├── description: "..."
│   ├── categories: ["BRUD", "ZIMNICA"]
│   ├── timestamp: Timestamp
│   ├── username: "user@email.com"
│   ├── userId: "firebase-uid"
│   └── city: "KRAKÓW"

incidents_by_line/
├── {lineNumber}
│   ├── line: "1"
│   └── incidentsCount: 42

top_categories/
├── {categoryId}
│   └── (category statistics)
```

Incident creation uses batch writes to atomically update both `incidents` and `incidents_by_line` collections.

### Platform-Specific
- **Android**: Kotlin-based, uses Gradle KTS for build configuration
  - MainActivity: `android/app/src/main/kotlin/com/gigapingu/trammageddon/MainActivity.kt`
  - Build configuration: `android/app/build.gradle.kts`
- **iOS**: Standard Flutter iOS setup with Swift

## Coding Conventions

### Widget Organization
- Screens go in `lib/screens/[feature]/` directories
- Screen-specific widgets can be colocated in the same feature directory
- Reusable widgets go in `lib/widgets/`
- Use const constructors where possible for performance
- Follow Material 3 theming through `Theme.of(context)` rather than hardcoding colors
- No comments in code - code should be self-documenting

### Styling
- Access colors via `Theme.of(context).colorScheme` or `AppColors`
- Text styles via `Theme.of(context).textTheme`
- Maintain zero border radius and thick borders for consistency
- Use existing custom widgets when applicable
- Text should be ALL UPPERCASE for maintaining the aesthetic

### File Naming
- Snake_case for Dart files
- Class names in PascalCase matching file names
- Screen widgets suffixed with `Screen` (e.g., `LoginScreen`)
- One widget per file

### Modern Patterns
- Use modern Dart features (3.9+)
- Use null safety
- Avoid nullable types when possible
- Use const constructors when possible
- Controllers for text input (TextEditingController)
- Sets for multi-selection (Set<String>)

### Import Organization
1. Flutter/Dart packages
2. Third-party packages
3. Local imports (../widgets, ../theme, etc.)

## Dependencies

Key packages:
- `go_router: ^17.0.0` - Declarative routing with auth guards
- `get_it: ^9.1.1` - Service locator for dependency injection
- `firebase_core`, `firebase_auth`, `cloud_firestore` - Firebase backend
- `shared_preferences: ^2.5.3` - Local user data persistence
- `crypto: ^3.0.7` - Password hashing (SHA-256)

Fonts in `lib/assets/font/`:
- Oswald (weights 200-700) - Headers
- ChivoMono (weights 200-700) - Body text

## Design Patterns

### Form Validation
```dart
bool get _isFormValid {
  return _requiredField1.isNotEmpty &&
         _requiredField2.isNotEmpty;
}

@override
void initState() {
  super.initState();
  _controller.addListener(() {
    setState(() {});
  });
}
```

### Category Toggle
```dart
void _toggleCategory(String category) {
  setState(() {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
  });
}
```

### Service Access Pattern
```dart
final authService = getIt.get<AuthService>();
await authService.login(email, password);
```

### Memory Management
- Always dispose controllers in `dispose()` method
- Remove listeners before disposal
- Cancel streams and timers when needed

## Android Build Configuration

- Uses Gradle with Kotlin DSL (`.kts` files)
- Application ID: `com.gigapingu.trammageddon`
- Java 11 compatibility
- Release builds currently use debug signing config (needs proper signing setup for production)

## Navigation Patterns

### FAB Visibility
The `ScaffoldWithNav` controls FAB visibility per route. Routes listed in `skipAppBarRoutes` hide the FAB (currently `/hall-of-defame` and `/settings`).

### Basic Navigation with GoRouter
```dart
context.go(RouteNames.addIncident);
context.push(RouteNames.hallOfDefame);
context.pop();
```

### Route Names
Use constants from `RouteNames` class rather than hardcoded strings:
- `RouteNames.home` → `/`
- `RouteNames.login` → `/login`
- `RouteNames.addIncident` → `/add-incident`
- `RouteNames.hallOfDefame` → `/hall-of-defame`
- `RouteNames.settings` → `/settings`
- `RouteNames.lineDetails` → `/line-details`

## Adding New Features

### Adding a New Service
1. Create `lib/services/my_service.dart`
2. Register in `main.dart`:
   ```dart
   getIt.registerSingleton<MyService>(MyService());
   // or for async initialization:
   getIt.registerSingletonAsync<MyService>(() => MyService.init());
   ```
3. Access via `getIt.get<MyService>()`

### Adding a New Screen
1. Create `lib/screens/feature_name/feature_name_screen.dart`
2. Add route constant to `lib/routing/route_names.dart`
3. Add route to `lib/routing/app_router.dart` (inside ShellRoute for nav bar, outside for full-screen)
4. Navigate with `context.go(RouteNames.featureName)`
