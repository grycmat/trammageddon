# Trammageddon

**Release your rage!**

A Flutter mobile application for reporting and tracking tram (public transport) incidents in Kraków, Poland with a brutalist design aesthetic.

## Project Overview

- **Package Name**: `com.gigapingu.trammageddon`
- **Framework**: Flutter 3.9+
- **Language**: Dart
- **Platforms**: Android and iOS
- **Backend**: Firebase (Auth, Firestore)

Trammageddon allows users to report problems with trams, view rankings of the most problematic lines, and see statistics about incidents. Built with a dark, industrial "wanted poster" aesthetic featuring sharp corners, high contrast, and bold typography.

## Getting Started

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart 3.9+ SDK
- Android Studio / Xcode for platform-specific development
- Firebase project configured

### Installation

```bash
# Clone the repository
git clone <repository-url>
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

# Build APK (Android)
flutter build apk

# Build for iOS
flutter build ios

# Clean build artifacts
flutter clean
```

### Asset Generation

```bash
# Regenerate app icons
flutter pub run flutter_launcher_icons

# Regenerate splash screen
flutter pub run flutter_native_splash:create
```

## Design Language

### Visual Style

The app features a distinctive brutalist/distress design inspired by warning posters and official notices:

- **Colors**: Black background, white text, red accents
- **Typography**: Oswald (headlines), ChivoMono (body text)
- **UI Elements**: Sharp corners (no rounded borders), dashed/solid borders
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
├── main.dart                    # App entry point with GetIt service registration
├── layout/
│   └── scaffold_with_nav.dart   # Persistent navigation wrapper
├── model/
│   ├── incident.model.dart      # Incident data model
│   ├── incident_by_line.dart    # Line aggregation model
│   ├── ranking_item.model.dart  # Ranking data model
│   ├── user.model.dart          # User model
│   ├── upvote.dart              # Upvote model
│   ├── category.model.dart      # Category model
│   ├── city.model.dart          # City model
│   └── tram_line.model.dart     # Tram line model
├── routing/
│   ├── app_router.dart          # GoRouter with ShellRoute configuration
│   └── route_names.dart         # Route path constants
├── screens/
│   ├── login/                   # Login/register screen
│   ├── dashboard/               # Dashboard with data visualization
│   ├── add_incident/            # Incident reporting form
│   ├── hall_of_defame/          # Rankings screen
│   ├── settings/                # User settings
│   └── line_details/            # Line details with incident list
├── services/
│   ├── auth.service.dart        # Firebase Auth + SharedPreferences
│   ├── incident.service.dart    # Firestore incident operations
│   └── preferences.service.dart # SharedPreferences wrapper
├── widgets/                     # Reusable UI components
├── theme/
│   ├── theme.dart               # App theme definitions
│   └── colors.dart              # Color palette
└── data/
    ├── categories.dart          # Incident categories
    ├── cities.dart              # Supported cities
    ├── tram_lines.dart          # Kraków tram lines
    └── DATA.dart                # Seed data for Firebase
```

## Architecture

### State Management

- **GetIt (Service Locator)**: Singleton pattern for global services
- **ChangeNotifier**: `AuthService` extends `ChangeNotifier` to trigger route refreshes
- **Local State**: `StatefulWidget` with `setState()` for forms and UI state
- **SharedPreferences**: User data persistence (username, userId, theme)

### Navigation

The app uses **GoRouter** for declarative routing with authentication guards:

- Uses `ShellRoute` pattern with `ScaffoldWithNav` for persistent bottom navigation
- Authentication guards redirect unauthenticated users to login

**Available Routes:**
- `/` - Dashboard (home)
- `/login` - Login screen
- `/add-incident` - Add incident form
- `/hall-of-defame` - Rankings screen
- `/settings` - User settings
- `/line-details` - Line details

### Backend Integration

Firebase services:
- **Firebase Auth**: Email/password authentication
- **Cloud Firestore**: Incident data storage with real-time updates

### Firestore Data Structure

```
incidents/
├── {docId}
│   ├── line: "1"
│   ├── lineId: "line_1"
│   ├── vehicleNumber: "optional"
│   ├── description: "..."
│   ├── categories: ["BRUD", "ZIMNICA"]
│   ├── timestamp: Timestamp
│   ├── username: "user@email.com"
│   ├── userId: "firebase-uid"
│   ├── city: "KRAKÓW"
│   └── upvotes: 0

incidents_by_line/
├── {lineId}
│   ├── line: "1"
│   ├── lineId: "line_1"
│   └── incidentsCount: 42

top_categories/
├── {categoryId}
│   ├── category: "BRUD I SMROD"
│   └── count: 15
```

## Seed Data

The project includes seed data for development and testing in `lib/data/DATA.dart`:

```dart
import 'package:trammageddon/data/DATA.dart';

// Upload all seed data (optionally clear existing first)
final uploader = SeedDataUploader();
await uploader.uploadAllSeedData(clearExisting: true);

// Or upload individual collections
await uploader.uploadIncidents();
await uploader.uploadIncidentsByLine();
await uploader.uploadTopCategories();
```

The seed data includes:
- 20 realistic sample incidents across various tram lines
- Incident aggregations by line
- Category statistics

## Dependencies

```yaml
dependencies:
  flutter: sdk
  go_router: ^17.0.0
  get_it: ^9.1.1
  firebase_core: ^4.2.1
  firebase_auth: ^6.1.2
  cloud_firestore: ^6.1.0
  shared_preferences: ^2.5.3
  crypto: ^3.0.7
  intl: ^0.19.0
  flutter_launcher_icons: ^0.14.4
  flutter_native_splash: ^2.4.7

dev_dependencies:
  flutter_lints: ^6.0.0
  flutter_test: sdk
```

## Color Palette

### Dark Theme (Primary)
- Background: `#000000` (Pure Black)
- Primary: `#EF4444` (Accent Red)
- On Surface: `#FFFFFF` (Pure White)

### Light Theme (Alternative)
- Background: `#FAFAFA` (Light Gray)
- Primary: `#FF5252` (Accent Red Light)
- On Surface: `#1F1F1F` (Dark Gray)

All colors defined in `lib/theme/colors.dart` as `AppColors` constants.

## Coding Standards

- One widget per file
- Snake_case for file names, PascalCase for class names
- Screen widgets suffixed with `Screen`
- No comments - code should be self-documenting
- Use const constructors when possible
- Text in ALL UPPERCASE for UI consistency
- Zero border radius on all elements

## Platform-Specific

### Android
- Uses Gradle with Kotlin DSL (`.kts` files)
- Application ID: `com.gigapingu.trammageddon`
- Java 11 compatibility

### iOS
- Standard Flutter iOS setup with Swift
- SafeArea handling for notch/dynamic island

## Localization

Currently hardcoded in Polish. Ready for internationalization using Flutter's localization packages.

---

**Trammageddon** - Because sometimes you just need to release your rage about public transport.
