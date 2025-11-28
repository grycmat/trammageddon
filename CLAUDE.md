# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Trammageddon is a Flutter mobile application with a distinct brutalist/distress design aesthetic using red and black color schemes. The application package is `com.gigapingu.trammageddon`.

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
- `cd android && ./gradlew clean` - Clean Android build (Windows: `gradlew.bat clean`)
- `cd android && ./gradlew assembleDebug` - Build debug APK via Gradle

## Architecture

### Project Structure
- `lib/` - Main application code
  - `main.dart` - Entry point, defines `Trammageddon` root widget
  - `screens/` - Screen-level widgets organized by feature
    - `login/` - Login screen and related components
  - `widgets/` - Reusable UI components
    - `verification_frame.dart` - Bordered container for forms
    - `stamped_button.dart` - Custom styled button component
    - `app_text_field.dart` - Custom text input component
  - `theme/` - Theme and styling
    - `theme.dart` - Defines `AppTheme` with dark and light themes
    - `colors.dart` - Centralized color palette in `AppColors`
  - `routing/` - Navigation configuration
    - `app_router.dart` - GoRouter setup with brutalist page transitions
    - `route_names.dart` - Centralized route path constants
    - `guards/auth_guard.dart` - Authentication state manager

### Routing System
The app uses `go_router` for declarative routing with authentication guards:
- `AppRouter` configured in `main.dart` with `AuthGuard` integration
- `AuthGuard` extends `ChangeNotifier` to trigger route refreshes on auth state changes
- Routes redirect unauthenticated users to login screen
- Custom brutalist page transitions: sharp cut at 50% animation progress (no fade, instant switch)
- Initial route is `/login` until home screen is implemented

### Theme System
The app uses a custom brutalist design with:
- Two font families: `Oswald` (headers) and `ChivoMono` (body/labels)
- Zero border radius (sharp, angular UI)
- Heavy borders (2-4px)
- High contrast color scheme with red accents
- Both dark mode (default) and light mode support
- Material 3 design system

Color scheme enforces:
- Dark theme: Black background with red accents (`accentRed`, `distressRed`)
- Light theme: White/gray backgrounds with lighter red accents
- No gradients or shadows, flat design approach

### State Management
Currently using basic StatefulWidget for local state (e.g., `LoginScreen`). No global state management library is integrated.

### Platform-Specific
- **Android**: Kotlin-based, uses Gradle KTS for build configuration
  - MainActivity: `android/app/src/main/kotlin/com/gigapingu/trammageddon/MainActivity.kt`
  - Min SDK determined by Flutter defaults
  - Build configuration: `android/app/build.gradle.kts`
- **iOS**: Standard Flutter iOS setup with Swift

## Coding Conventions

### Widget Organization
- Screens go in `lib/screens/[feature]/` directories
- Reusable widgets go in `lib/widgets/`
- Use const constructors where possible for performance
- Follow Material 3 theming through `Theme.of(context)` rather than hardcoding colors

### Styling
- Access colors via `Theme.of(context).colorScheme` or `AppColors`
- Text styles via `Theme.of(context).textTheme`
- Maintain zero border radius and thick borders (2-4px) for consistency
- Use existing custom widgets (`VerificationFrame`, `StampedButton`, `AppTextField`) when applicable

### File Naming
- Snake_case for Dart files
- Class names in PascalCase matching file names
- Screen widgets suffixed with `Screen` (e.g., `LoginScreen`)

## Dependencies

Current dependencies (from pubspec.yaml):
- `flutter` (SDK)
- `cupertino_icons: ^1.0.8`
- `go_router: ^17.0.0`

Dev dependencies:
- `flutter_test` (SDK)
- `flutter_lints: ^5.0.0`

## Testing

Tests are located in `test/`. Note that the current `widget_test.dart` contains boilerplate code referencing `MyApp` which doesn't exist in the codebase - it should be updated to test `Trammageddon` or `LoginScreen`.

Run specific test: `flutter test test/widget_test.dart`

## Android Build Configuration

- Uses Gradle with Kotlin DSL (`.kts` files)
- Build directory configured to use `../../build` to keep artifacts outside android folder
- Java 11 compatibility
- Application ID: `com.gigapingu.trammageddon`
- Release builds currently use debug signing config (needs proper signing setup for production)
