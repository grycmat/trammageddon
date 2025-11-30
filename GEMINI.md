# Trammageddon

## Project Overview
Trammageddon is a Flutter mobile application designed with a brutalist aesthetic for reporting and tracking tram incidents. It features a high-contrast dark/red design, custom typography (Oswald & ChivoMono), and sharp angular UI elements. The app allows users to report incidents, view rankings of problematic tram lines, and see statistics.

## Tech Stack
- **Framework**: Flutter (Dart)
- **Routing**: `go_router` with custom "brutalist" page transitions (instant cuts).
- **Backend**: Firebase (Core, Firestore) via `flutter_dotenv` for configuration.
- **State Management**: Local state (`setState`, `ChangeNotifier` for Auth).
- **Theming**: Custom `AppTheme` (Dark & Light) with Material 3 support.
- **Fonts**: Oswald (Headlines), ChivoMono (Body).

## Architecture
- **Navigation**: `ShellRoute` with `ScaffoldWithNav` for persistent bottom navigation.
- **Screens**: Feature-based organization (`lib/screens/`).
- **Widgets**: Reusable UI components in `lib/widgets/`.
- **Style**: Strict adherence to brutalist design principles (0px border radius, thick borders, uppercase text).

## Key Directories & Files
- `lib/main.dart`: App entry point, provider setup.
- `lib/routing/`: Routing configuration (`app_router.dart`, `route_names.dart`) and guards.
- `lib/theme/`: Theme definitions (`theme.dart`) and color palette (`colors.dart`).
- `lib/screens/`:
  - `dashboard/`: Home screen with stats.
  - `add_incident/`: Incident reporting form.
  - `hall_of_defame/`: Rankings list.
  - `login/`: Authentication screen (Username only, Auto-login support).
- `lib/widgets/`: Shared components like `StampedButton`, `AppTextField`, `VerificationFrame`.

## Development Commands
- **Run Debug**: `flutter run`
- **Run Release**: `flutter run --release`
- **Tests**: `flutter test`
- **Analyze**: `flutter analyze`
- **Build Android**: `flutter build apk`
- **Build iOS**: `flutter build ios`

## Conventions
- **Design**: 
  - **NO** rounded corners (BorderRadius.zero).
  - **ALL CAPS** for text where appropriate.
  - **High Contrast**: Black/Red/White.
- **Code**:
  - Use `const` constructors where possible.
  - Access theme via `Theme.of(context)`.
  - Use named routes from `RouteNames`.
  - One widget per file.
  - Snake_case for filenames, PascalCase for classes.

## Setup
1. Ensure Flutter SDK 3.9+ is installed.
2. Create `.env` file with Firebase configuration.
3. Run `flutter pub get`.
4. Run `flutter run`.
