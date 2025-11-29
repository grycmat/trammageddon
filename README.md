# Trammageddon

**Release your rage!**

A Flutter mobile application for reporting and tracking tram (public transport) incidents with a brutalist design aesthetic.

## Project Overview

- **Package Name**: `com.gigapingu.trammageddon`
- **Framework**: Flutter 3.9+
- **Language**: Dart
- **Platforms**: Android and iOS

Trammageddon allows users to report problems with trams, view rankings of the most problematic lines, and see statistics about incidents. Built with a dark, industrial "wanted poster" aesthetic featuring sharp corners, high contrast, and bold typography.

## Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Android Studio / Xcode for platform-specific development
- Dart 3.9+ SDK

### Installation

```bash
# Clone the repository
git clone <repository-url>

# Navigate to project directory
cd trammageddon

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Development Commands

```bash
# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Run tests
flutter test

# Run static analysis
flutter analyze

# Clean build artifacts
flutter clean

# Build APK (Android)
flutter build apk

# Build for iOS
flutter build ios
```

## Design Language

### Visual Style

The app features a distinctive brutalist/distress design inspired by warning posters and official notices:

- **Colors**: Black background, white text, red accents
- **Typography**: Oswald (headlines), ChivoMono (body text)
- **UI Elements**: Sharp corners (no rounded borders), dashed/solid borders, rotated buttons
- **Text Style**: ALL UPPERCASE for emphasis and impact

### Design Principles

- Zero border radius - square corners only
- High contrast (black/white/red color scheme)
- Bold, attention-grabbing typography
- Industrial/utilitarian aesthetic
- No gradients or shadows - flat design approach

## Project Structure

```
lib/
├── main.dart                    # App entry point with router setup
├── layout/
│   └── scaffold_with_nav.dart   # Persistent navigation wrapper
├── model/
│   └── ranking.model.dart       # Data models
├── routing/
│   ├── app_router.dart          # GoRouter with ShellRoute configuration
│   ├── route_names.dart         # Route path constants
│   └── guards/
│       └── auth_guard.dart      # Authentication guard
├── screens/
│   ├── login/
│   │   └── login.screen.dart
│   ├── dashboard/
│   │   ├── dashboard_screen.dart
│   │   ├── data_box.dart
│   │   └── top_ranking_item.dart
│   ├── add_incident/
│   │   ├── add_incident.screen.dart
│   │   ├── wanted_border.dart
│   │   ├── statement_frame.dart
│   │   ├── category_tag.dart
│   │   ├── app_dropdown.dart
│   │   └── app_text_area.dart
│   └── hall_of_defame/
│       ├── hall_of_defame_screen.dart
│       └── detailed_ranking_entry.dart
├── widgets/
│   ├── verification_frame.dart  # Reusable components
│   ├── stamped_button.dart
│   ├── app_text_field.dart
│   ├── top_bar.dart
│   └── nav_bar.dart
└── theme/
    ├── theme.dart               # App theme definitions
    └── colors.dart              # Color palette
```

## Architecture

### Navigation

The app uses **GoRouter** for declarative routing with authentication guards:

- Initial route: `/` (Dashboard)
- Uses `ShellRoute` pattern with `ScaffoldWithNav` for persistent bottom navigation
- Authentication guards ready (currently commented out during development)
- Custom brutalist page transitions via `CustomTransitionPage` (sharp cut at 50% animation - no fade, instant switch)

**Available Routes:**
- `/` - Dashboard (home)
- `/login` - Login screen
- `/add-incident` - Add incident form
- `/hall-of-defame` - Rankings screen

**Navigation Example:**
```dart
// Navigate using route names
context.go(RouteNames.addIncident);
context.push(RouteNames.hallOfDefame);
context.pop();
```

### Theme System

The app uses Material 3 with custom theming:

- **Dark Theme** (default): Pure black background with red accents
- **Light Theme** (alternative): Light gray/white with red accents
- **Fonts**: Oswald (weights 200-700), ChivoMono (referenced but needs setup)

**Always use theme access:**
```dart
color: Theme.of(context).colorScheme.primary
style: Theme.of(context).textTheme.headlineLarge
```

**Never hardcode colors or text styles.**

### State Management

Currently using StatefulWidget for local state:
- TextEditingController for text inputs
- Set<String> for multi-selection
- Basic setState for state updates

No global state management library is integrated.

### Backend Integration

The app uses **Firebase** for backend services:
- **Firebase Core** for initialization
- **Cloud Firestore** for data persistence and real-time updates
- **flutter_dotenv** for environment variable management

**Setup:**
1. Create a `.env` file in the project root (not committed to git)
2. Add Firebase configuration credentials
3. Run `flutter pub get` to install dependencies

## Key Screens

### DashboardScreen
- **Route**: `/` (home)
- Main landing page with data visualization
- Uses DataBox and TopRankingItem widgets

### HallOfDefameScreen
- **Route**: `/hall-of-defame`
- Displays rankings of most problematic tram lines
- Uses DetailedRankingEntry widgets for detailed entries

### AddIncidentScreen
- **Route**: `/add-incident`
- Form for reporting tram incidents
- Features:
  - Tram line dropdown (Krakow tram lines)
  - Vehicle number input
  - Multi-line description
  - Category tags (multiple selection)
  - Form validation

### LoginScreen
- **Route**: `/login`
- User authentication interface
- Form validation with disabled state

## Data Models

### Ranking
```dart
class Ranking {
  final int rank;
  final String line;
  final int reports;
}
```

## Common Patterns

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

### Category Toggle (Multi-selection)
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
```dart
@override
void dispose() {
  _controller.dispose();
  _controller.removeListener(_listener);
  super.dispose();
}
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  go_router: ^17.0.0
  firebase_core: ^4.2.1
  cloud_firestore: ^6.1.0
  flutter_dotenv: ^6.0.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

### Fonts

Oswald font files are located in `lib/assets/font/`:
- Oswald-ExtraLight.ttf (200)
- Oswald-Light.ttf (300)
- Oswald-Regular.ttf (400)
- Oswald-Medium.ttf (500)
- Oswald-SemiBold.ttf (600)
- Oswald-Bold.ttf (700)

ChivoMono is referenced in the theme but needs to be added to assets.

## Color Palette

### Dark Theme (Primary)
- Background: `#000000` (Pure Black)
- Primary: `#EF4444` (Accent Red)
- Primary Container: `#DC2626` (Distress Red)
- On Surface: `#FFFFFF` (Pure White)
- Surface: Semi-transparent black

### Light Theme (Alternative)
- Background: `#FAFAFA` (Light Gray)
- Surface: `#FFFFFF` (White)
- Primary: `#FF5252` (Accent Red Light)
- Primary Container: `#E53935` (Distress Red Light)
- On Surface: `#1F1F1F` (Dark Gray)

All colors defined in `lib/theme/colors.dart` as `AppColors` constants.

## Coding Standards

### File Organization
- One widget per file
- Snake_case for file names
- PascalCase for class names
- Screen widgets suffixed with `Screen`

### Import Order
1. Flutter/Dart packages
2. Third-party packages
3. Local imports

### Best Practices
- Use const constructors when possible
- Use null safety (avoid nullable types when possible)
- No comments - code should be self-documenting
- Use modern Dart 3.9+ features
- Dispose controllers in `dispose()` method
- Text in ALL UPPERCASE for UI consistency

## Design System

### Spacing Scale
- 4px: Minimal spacing
- 8px: Small spacing
- 12px: Medium spacing
- 16px: Standard padding
- 24px: Large spacing

### Border Widths
- 1px: Category tags
- 2px: Input fields, ranking entries, borders
- 3px: Statement frames, buttons
- 4px: Verification frame, wanted border

### Corner Radius
- **0px**: All elements (square corners only)

## Platform-Specific

### Android
- Minimum SDK: Determined by Flutter defaults
- Uses Gradle with Kotlin DSL (`.kts` files)
- Application ID: `com.gigapingu.trammageddon`
- MainActivity: `android/app/src/main/kotlin/com/gigapingu/trammageddon/MainActivity.kt`

### iOS
- Standard Flutter iOS setup with Swift
- SafeArea handling for notch/dynamic island

## Localization

Currently hardcoded in Polish. The app is ready for internationalization using Flutter's localization packages.

## Troubleshooting

**Fonts not displaying**
```bash
flutter clean
flutter pub get
flutter run
```

**Theme colors not working**
- Always use `Theme.of(context).colorScheme.*`
- Never use hardcoded Color values

**Build errors**
```bash
# Clean and rebuild
flutter clean
cd android && gradlew.bat clean
cd ..
flutter pub get
flutter run
```

## Future Enhancements

Potential features for development:
1. Full authentication system with Firebase Auth
2. Push notifications via Firebase Cloud Messaging
3. Geolocation integration for automatic tram line detection
4. Photo uploads with Firebase Storage
5. User comments and discussions
6. Detailed analytics and graphs
7. Advanced filtering and search
8. User profiles and preferences
9. Multi-language support (currently Polish)
10. Offline mode with local caching

## Contributing

When contributing to this project:
- Follow the existing code style and conventions
- Maintain the brutalist design aesthetic
- Use const constructors where possible
- Write self-documenting code (no comments)
- Test on both Android and iOS when possible
- Ensure all text is UPPERCASE in the UI

## License

[Specify your license here]

---

**Trammageddon** - Because sometimes you just need to release your rage about public transport.
