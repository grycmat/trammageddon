# Trammageddon

## Project Overview
Trammageddon is a Flutter mobile application designed with a brutalist aesthetic for reporting and tracking tram incidents in Kraków. It features a high-contrast dark/red design, custom typography (Oswald & ChivoMono), and sharp angular UI elements. The app allows users to report incidents ("żale"), view rankings of problematic tram lines ("Hall of Defame"), and track statistics.

## Tech Stack
- **Framework**: Flutter (Dart)
- **Routing**: `go_router` with custom "brutalist" page transitions (instant cuts/no animation).
- **Dependency Injection**: `get_it` (Service Locator) for accessing global services like `PreferencesService` and `AuthGuard`.
- **State Management**: 
  - `setState` for local widget state.
  - `ChangeNotifier` (via `AuthGuard`) for authentication state synchronization.
  - `GetIt` for singleton instance management.
- **Persistence**: `shared_preferences` for storing user settings (username, theme).
- **Backend**: *Currently using local mock data and SharedPreferences.* Firebase configuration files exist, but active cloud integration is not yet implemented in the primary logic.
- **Theming**: Custom `AppTheme` (Dark & Light) with Material 3 support.
- **Fonts**: Oswald (Headlines), ChivoMono (Body).

## Architecture
- **Navigation**: 
  - `GoRouter` handles navigation.
  - `ShellRoute` wraps the main application with `ScaffoldWithNav` for a persistent bottom navigation bar.
  - `AuthGuard` implements `Listenable` to automatically redirect users based on login state.
- **Screens**: Feature-based organization (`lib/screens/`).
- **Widgets**: Reusable UI components in `lib/widgets/`.
- **Style**: Strict adherence to brutalist design principles (0px border radius, thick borders, uppercase text, high contrast).

## Key Directories & Files
- `lib/main.dart`: App entry point, `GetIt` service registration.
- `lib/routing/`: 
  - `app_router.dart`: Router configuration and transition logic.
  - `guards/auth_guard.dart`: Authentication logic and state.
  - `route_names.dart`: Route path constants.
- `lib/theme/`: 
  - `theme.dart`: ThemeData definitions.
  - `colors.dart`: `AppColors` palette.
- `lib/screens/`:
  - `dashboard/`: Home screen with "Dziś w mieście" stats and personal summary.
  - `add_incident/`: Incident reporting form with custom inputs (`AppDropdown`, `WantedBorder`).
  - `hall_of_defame/`: Rankings list (`HallOfDefameScreen`).
  - `settings/`: User preferences (Username, Theme, City).
  - `login/`: Authentication screen (Username only).
- `lib/widgets/`: Shared components like `StampedButton`, `AppTextField`, `VerificationFrame`, `NavBar`.
- `lib/services/`: `PreferencesService` wrapper for `SharedPreferences`.

## Development Commands
- **Run Debug**: `flutter run`
- **Run Release**: `flutter run --release`
- **Tests**: `flutter test`
- **Analyze**: `flutter analyze`

## Conventions
- **Design**: 
  - **NO** rounded corners (`BorderRadius.zero`).
  - **ALL CAPS** for headlines and labels.
  - **High Contrast**: Black/Red/White palette.
  - **Icons**: Material Icons, generally consistently styled or wrapped.
- **Code**:
  - Use `GetIt.I.get<T>()` for accessing global services.
  - Use named routes from `RouteNames`.
  - Access theme colors via `Theme.of(context).colorScheme`.
  - Filenames in `snake_case`, classes in `PascalCase`.
  - One widget per file preferred.

## Setup
1. Ensure Flutter SDK is installed.
2. Run `flutter pub get`.
3. Run `flutter run`.
