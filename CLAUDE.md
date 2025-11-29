# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Trammageddon is a Flutter mobile application for reporting and tracking tram (public transport) incidents. The application features a distinct brutalist/distress design aesthetic using red and black color schemes with an industrial, "wanted poster" visual style. Application package: `com.gigapingu.trammageddon`.

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
- `lib/main.dart` - Entry point, defines `Trammageddon` root widget with router setup
- `lib/screens/` - Screen-level widgets organized by feature
  - `login/` - Login screen
  - `add_incident/` - Incident reporting screen and related widgets (wanted_border, statement_frame, category_tag, app_dropdown, app_text_area)
  - `dashboard/` - Dashboard screen with data visualization (data_box, top_ranking_item)
  - `hall_of_defame/` - Hall of shame/rankings screen with detailed entries
- `lib/widgets/` - Reusable UI components
  - `verification_frame.dart` - Bordered container for forms
  - `stamped_button.dart` - Custom styled button component
  - `app_text_field.dart` - Custom text input component
  - `top_bar.dart` - Top navigation bar
  - `nav_bar.dart` - Bottom navigation bar
- `lib/theme/` - Theme and styling
  - `theme.dart` - Defines `AppTheme` with dark and light themes
  - `colors.dart` - Centralized color palette in `AppColors`
- `lib/routing/` - Navigation configuration
  - `app_router.dart` - GoRouter setup with brutalist page transitions
  - `route_names.dart` - Centralized route path constants
  - `guards/auth_guard.dart` - Authentication state manager
- `lib/model/` - Data models
  - `ranking.model.dart` - Ranking data structure

### Routing System
The app uses `go_router` for declarative routing with authentication guards:
- `AppRouter` configured in `main.dart` with `AuthGuard` integration
- `AuthGuard` extends `ChangeNotifier` to trigger route refreshes on auth state changes
- Authentication guards currently commented out during development
- Custom brutalist page transitions: sharp cut at 50% animation progress (no fade, instant switch)
- Initial route is `/` (home/dashboard)
- Routes defined in `RouteNames`:
  - `/login` - Login screen
  - `/` - Dashboard (home)
  - `/add-incident` - Add incident screen
  - `/hall-of-defame` - Rankings screen
  - Future routes: `/profile`, `/settings`, `/tram-map`

### Theme System
The app uses a custom brutalist design with:
- Two font families: `Oswald` (weights 200-700 for headers) and `ChivoMono` (body/labels)
- Zero border radius (sharp, angular UI)
- Heavy borders (1-4px depending on element)
- High contrast color scheme with red accents
- Both dark mode (default) and light mode support
- Material 3 design system

Color scheme enforces:
- Dark theme: Black background with red accents (`accentRed`, `distressRed`)
- Light theme: White/gray backgrounds with lighter red accents
- No gradients or shadows, flat design approach
- ALL text in uppercase for emphasis and impact

Visual style characteristics:
- Sharp corners (borderRadius: 0)
- Industrial/utilitarian aesthetic
- Inspired by warning posters and official notices
- Dashed and solid borders for different sections
- Rotated buttons with hover/press effects

### Data Models
- `Ranking` model: Contains `rank`, `line`, and `reports` fields for ranking entries

### State Management
Currently using basic StatefulWidget for local state. No global state management library is integrated.

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

Current dependencies (from pubspec.yaml):
- `flutter` (SDK)
- `cupertino_icons: ^1.0.8`
- `go_router: ^17.0.0`

Dev dependencies:
- `flutter_test` (SDK)
- `flutter_lints: ^5.0.0`

Fonts:
- Oswald (weights 200-700) - `lib/assets/font/Oswald-*.ttf`
- ChivoMono (Note: Not in pubspec.yaml but referenced in theme)

## Key Screens

### DashboardScreen
- Route: `/` (home)
- Features data visualization boxes and top rankings
- Uses DataBox and TopRankingItem widgets

### HallOfDefameScreen
- Route: `/hall-of-defame`
- Displays rankings of most problematic tram lines
- Uses DetailedRankingEntry widgets

### AddIncidentScreen
- Route: `/add-incident`
- Form for reporting tram incidents
- Uses WantedBorder, StatementFrame, CategoryTag, AppDropdown, AppTextArea
- Tram line selection (Krakow tram data)
- Category selection with multiple tags

### LoginScreen
- Route: `/login`
- User authentication interface
- Uses VerificationFrame, AppTextField, StampedButton

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

### Basic Navigation with GoRouter
```dart
context.go(RouteNames.addIncident);
context.push(RouteNames.hallOfDefame);
context.pop();
```

### Route Names
Use constants from `RouteNames` class rather than hardcoded strings.
