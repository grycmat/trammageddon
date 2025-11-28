# Trammageddon - Flutter App Documentation

## Project Overview

**Package Name**: com.gigapingu.trammageddon
**Application Name**: Trammageddon
**Platforms**: Android and iOS
**Framework**: Flutter
**Language**: Dart

Trammageddon is a mobile application for reporting and tracking tram (public transport) incidents. Users can report problems with trams, view rankings of the most problematic lines, and see daily statistics about incidents.

## Design Language

### Visual Style
- **Theme**: Dark, industrial, "wanted poster" aesthetic
- **Colors**: Black background, white text, red accents
- **Typography**: Oswald (bold, headlines), Chivo Mono (body text)
- **UI Elements**: Sharp corners (no rounded borders), dashed/solid borders, rotated buttons
- **Text Style**: ALL UPPERCASE for emphasis and impact

### Design Principles
- No rounded corners (borderRadius: 0)
- High contrast (black/white/red)
- Bold, attention-grabbing typography
- Industrial/utilitarian aesthetic
- Inspired by warning posters and official notices

## Project Structure

```
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── add_incident_screen.dart
│   └── hall_of_shame_screen.dart
├── widgets/
│   ├── verification_frame.dart
│   ├── wanted_border.dart
│   ├── statement_frame.dart
│   ├── stamped_button.dart
│   ├── app_text_field.dart
│   ├── app_dropdown.dart
│   ├── app_text_area.dart
│   ├── category_tag.dart
│   └── ranking_entry.dart
└── theme/
    ├── colors.dart
    └── theme.dart
```

## Theme System

### Color Palette

**Dark Theme (Primary)**
- Background: #000000 (Pure Black)
- Surface: rgba(0, 0, 0, 0.7) (Semi-transparent black)
- Primary: #EF4444 (Accent Red)
- Primary Container: #DC2626 (Distress Red)
- On Surface: #FFFFFF (Pure White)
- On Surface Variant: #D1D5DB (Text Gray)
- Tertiary: rgba(255, 255, 255, 0.1) (Tag Inactive)

**Light Theme (Alternative)**
- Background: #FAFAFA (Light Gray)
- Surface: #FFFFFF (White)
- Primary: #FF5252 (Accent Red Light)
- Primary Container: #E53935 (Distress Red Light)
- On Surface: #1F1F1F (Dark Gray)
- On Surface Variant: #757575 (Light Gray)

### Typography

**Font Families**
1. **Oswald** (weight: 700)
    - Used for: Headlines, titles, buttons
    - Style: Bold, uppercase, attention-grabbing
    - Files: Oswald-Bold.ttf

2. **Chivo Mono** (weights: 400, 700)
    - Used for: Body text, labels, input fields
    - Style: Monospace, technical appearance
    - Files: ChivoMono-Regular.ttf, ChivoMono-Bold.ttf

**Text Styles**
- displayLarge/Medium/Small: Oswald, 57/45/36sp
- headlineLarge/Medium/Small: Oswald, 32/28/24sp
- titleLarge/Medium/Small: Oswald, 22/16/14sp
- bodyLarge/Medium/Small: ChivoMono, 16/14/12sp
- labelLarge/Medium/Small: ChivoMono Bold, 14/12/11sp

### Accessing Theme

All styling must use `Theme.of(context)`:
```dart
color: Theme.of(context).colorScheme.primary
style: Theme.of(context).textTheme.headlineLarge
```

**Never use hardcoded colors or direct color values.**

## Screens

### 1. LoginScreen
**Purpose**: User authentication
**Route**: `/login`
**File**: `lib/screens/login_screen.dart`

**UI Components**:
- Header with lock icon and "BEZPIECZNY DOSTĘP" title
- VerificationFrame containing:
    - Username/Email input field
    - Password input field (obscured)
- Bottom StampedButton (disabled until both fields filled)

**State**:
- `_usernameController`: TextEditingController
- `_passwordController`: TextEditingController
- `_isButtonEnabled`: bool (computed from field validation)

**Validation**:
- Button enabled when both fields have content
- No specific format validation

**Navigation**:
- On successful login → HallOfShameScreen

### 2. AddIncidentScreen
**Purpose**: Report new tram incidents
**Route**: `/add-incident`
**File**: `lib/screens/add_incident_screen.dart`

**UI Components**:
- Header with report_problem icon and "PILNE ZAWIADOMIENIE" title
- WantedBorder section:
    - Tram line dropdown (required)
    - Vehicle number input (optional)
- StatementFrame section:
    - Multi-line description textarea (required)
- Category selection with multiple tags
- Bottom StampedButton (disabled until required fields filled)

**State**:
- `_selectedLine`: String? (dropdown value)
- `_vehicleNumberController`: TextEditingController
- `_descriptionController`: TextEditingController
- `_selectedCategories`: Set<String> (multiple selection)

**Validation**:
- Required: Tram line, description
- Optional: Vehicle number, categories
- Button enabled when required fields valid

**Data**:
```dart
Tram Lines:
- '1 - Banacha -> Annopol'
- '3 - Gocławek -> Annopol'
- '7 - P+R Al. Krakowska -> Kawęczyńska-Bazylika'
- '9 - P+R Al. Krakowska -> Gocławek'
- '22 - Wiatraczna -> Piaski'

Categories:
- 'BRUD I SMRÓD'
- 'BRAK OGRZEWANIA/KLIMATYZACJI'
- 'SPÓŹNIENIE'
- 'TŁOK'
- 'AGRESYWNY PASAŻER'
- 'NIEBEZPIECZNA JAZDA'
```

**Navigation**:
- On submit → Return to previous screen or HallOfShameScreen

### 3. HallOfShameScreen
**Purpose**: Display ranking of most problematic tram lines
**Route**: `/ranking` or `/` (home)
**File**: `lib/screens/hall_of_shame_screen.dart`

**UI Components**:
- Header with leaderboard icon and "RANKING DNIA: INCYDENTY" title
- WantedBorder section:
    - Top 5 rankings (RankingEntry widgets)
- StatementFrame section:
    - Most frequent categories (CategoryTag widgets)
- StatementFrame section:
    - Daily report text
- Bottom StampedButton (navigate to add incident)

**State**:
- `_rankings`: List<RankingData> (top 5 lines)
- `_selectedCategories`: Set<String> (category filter)

**Data Model**:
```dart
class RankingData {
  final int rank;
  final String line;
  final int incidents;
}
```

**Sample Data**:
```dart
[
  RankingData(rank: 1, line: '7', incidents: 18),
  RankingData(rank: 2, line: '22', incidents: 15),
  RankingData(rank: 3, line: '9', incidents: 12),
  RankingData(rank: 4, line: '1', incidents: 10),
  RankingData(rank: 5, line: '3', incidents: 8),
]
```

## Reusable Widgets

### VerificationFrame
**Purpose**: Solid border container for verification/authentication sections
**File**: `lib/widgets/verification_frame.dart`

**Properties**:
- Border: 4px solid white
- Padding: 16px
- Background: Transparent

**Usage**:
```dart
VerificationFrame(
  child: YourContent(),
)
```

### WantedBorder
**Purpose**: Dashed border container for alert sections
**File**: `lib/widgets/wanted_border.dart`

**Properties**:
- Border: 4px dashed red (custom painted)
- Padding: 16px
- Background: Transparent

**Implementation**: CustomPainter for dashed border

**Usage**:
```dart
WantedBorder(
  child: YourContent(),
)
```

### StatementFrame
**Purpose**: Solid border container with semi-transparent background
**File**: `lib/widgets/statement_frame.dart`

**Properties**:
- Border: 3px solid white
- Padding: 16px
- Background: Semi-transparent black (from theme surface color)

**Usage**:
```dart
StatementFrame(
  child: YourContent(),
)
```

### StampedButton
**Purpose**: Animated red button with rotation effect
**File**: `lib/widgets/stamped_button.dart`

**Properties**:
- Default rotation: -3 degrees
- Pressed rotation: -1 degree, scale: 0.98
- Hover rotation: -5 degrees, scale: 1.02
- Glow shadow effects
- Supports disabled state (grayed out)

**Parameters**:
- `onPressed`: VoidCallback? (null for disabled)
- `icon`: IconData (Material icon)
- `label`: String (button text)

**Usage**:
```dart
StampedButton(
  onPressed: isEnabled ? _handleSubmit : null,
  icon: Icons.gavel,
  label: 'ZŁÓŻ OFICJALNE ZAWIADOMIENIE',
)
```

### AppTextField
**Purpose**: Single-line text input with theme styling
**File**: `lib/widgets/app_text_field.dart`

**Properties**:
- Border: 2px red (default), 2px white (focused)
- Background: Black
- Font: ChivoMono
- Square corners

**Parameters**:
- `controller`: TextEditingController
- `hintText`: String
- `obscureText`: bool (default: false)
- `keyboardType`: TextInputType (default: text)

**Usage**:
```dart
AppTextField(
  controller: _usernameController,
  hintText: 'WPROWADŹ DANE',
  keyboardType: TextInputType.emailAddress,
)
```

### AppDropdown
**Purpose**: Dropdown selector with theme styling
**File**: `lib/widgets/app_dropdown.dart`

**Properties**:
- Border: 2px white
- Background: Black
- Custom red arrow icon
- Font: ChivoMono
- Square corners

**Parameters**:
- `value`: String?
- `items`: List<String>
- `hint`: String
- `onChanged`: ValueChanged<String?>

**Usage**:
```dart
AppDropdown(
  value: _selectedLine,
  items: _tramLines,
  hint: 'WYBIERZ LINIĘ...',
  onChanged: (value) {
    setState(() {
      _selectedLine = value;
    });
  },
)
```

### AppTextArea
**Purpose**: Multi-line text input with theme styling
**File**: `lib/widgets/app_text_area.dart`

**Properties**:
- Border: 2px red (default), 2px white (focused)
- Background: Black
- Font: ChivoMono
- Auto-expanding
- Minimum lines: 8 (configurable)

**Parameters**:
- `controller`: TextEditingController
- `hintText`: String
- `minLines`: int (default: 8)

**Usage**:
```dart
AppTextArea(
  controller: _descriptionController,
  hintText: 'OPISZ PROBLEM WŁASNYMI SŁOWAMI...',
  minLines: 8,
)
```

### CategoryTag
**Purpose**: Selectable tag/chip for categories
**File**: `lib/widgets/category_tag.dart`

**Properties**:
- Inactive: Transparent white background, white text
- Selected: Red background, black text
- Border: 1px
- Font: ChivoMono Bold, uppercase
- Square corners

**Parameters**:
- `label`: String
- `isSelected`: bool
- `onTap`: VoidCallback

**Usage**:
```dart
CategoryTag(
  label: 'SPÓŹNIENIE',
  isSelected: _selectedCategories.contains('SPÓŹNIENIE'),
  onTap: () => _toggleCategory('SPÓŹNIENIE'),
)
```

### RankingEntry
**Purpose**: Individual ranking list item
**File**: `lib/widgets/ranking_entry.dart`

**Properties**:
- Border: 2px white
- Background: Semi-transparent black
- Rank: Large red monospace number (zero-padded)
- Line number: Highlighted in red
- Incident count: Highlighted in red

**Parameters**:
- `rank`: int
- `line`: String
- `incidents`: int

**Usage**:
```dart
RankingEntry(
  rank: 1,
  line: '7',
  incidents: 18,
)
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

### AppBar with Border
```dart
AppBar(
  leading: Padding(
    padding: const EdgeInsets.all(12.0),
    child: Icon(
      Icons.leaderboard,
      size: 28,
      color: Theme.of(context).colorScheme.primary,
    ),
  ),
  title: Text(
    'RANKING DNIA: INCYDENTY',
    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
      color: Theme.of(context).colorScheme.primary,
    ),
  ),
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(2),
    child: Container(
      height: 2,
      color: Theme.of(context).colorScheme.primary,
    ),
  ),
)
```

### Sticky Footer with Button
```dart
Container(
  decoration: BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
    border: Border(
      top: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    ),
  ),
  padding: const EdgeInsets.all(16),
  child: SafeArea(
    top: false,
    child: StampedButton(
      onPressed: _isFormValid ? _handleSubmit : null,
      icon: Icons.gavel,
      label: 'ZŁÓŻ OFICJALNE ZAWIADOMIENIE',
    ),
  ),
)
```

## Coding Standards

### Modern Patterns
- Use modern Dart features (3.0+)
- Use null safety
- Avoid nullable types when possible
- Use const constructors when possible

### No Comments
Code should be self-documenting. Do not include comments in code.

### Widget Naming
- Screens: `*Screen` (e.g., LoginScreen)
- Widgets: Descriptive names (e.g., StampedButton)
- Private methods: `_methodName`
- Private properties: `_propertyName`

### State Management
- Use StatefulWidget for local state
- Use setState for simple state updates
- Controllers for text input (TextEditingController)
- Sets for multi-selection (Set<String>)

### File Organization
- One widget per file
- File name matches widget name in snake_case
- Imports at top, organized:
    1. Flutter/Dart packages
    2. Third-party packages
    3. Local imports (../widgets, ../theme)

## Dependencies

### Required Packages
```yaml
dependencies:
  flutter:
    sdk: flutter
  material_symbols_icons: ^4.2785.1  # Optional for Material Symbols
```

### Fonts
```yaml
flutter:
  fonts:
    - family: Oswald
      fonts:
        - asset: assets/fonts/Oswald-Bold.ttf
          weight: 700
    
    - family: ChivoMono
      fonts:
        - asset: assets/fonts/ChivoMono-Regular.ttf
          weight: 400
        - asset: assets/fonts/ChivoMono-Bold.ttf
          weight: 700
```

## App Initialization

### main.dart
```dart
import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/hall_of_shame_screen.dart';

void main() {
  runApp(const TrammageddonApp());
}

class TrammageddonApp extends StatelessWidget {
  const TrammageddonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trammageddon',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const HallOfShameScreen(),
    );
  }
}
```

## Navigation

### Basic Navigation
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AddIncidentScreen(),
  ),
);
```

### Pop Back
```dart
Navigator.pop(context);
```

### Named Routes (Optional)
```dart
routes: {
  '/': (context) => const HallOfShameScreen(),
  '/login': (context) => const LoginScreen(),
  '/add-incident': (context) => const AddIncidentScreen(),
}
```

## Future Enhancements

### Potential Features
1. **Backend Integration**: Connect to API for real incident data
2. **User Authentication**: Full login/logout system
3. **Push Notifications**: Alert users to new incidents
4. **Geolocation**: Auto-detect tram line from GPS
5. **Photos**: Upload incident photos
6. **Comments**: User discussion on incidents
7. **Statistics**: Detailed analytics and graphs
8. **Filters**: Advanced filtering by date, line, category
9. **User Profiles**: Personal incident history
10. **Localization**: Support for multiple languages

### API Integration Points
```dart
Future<List<RankingData>> fetchRankings() async {
  final response = await http.get(Uri.parse('api/rankings'));
  final List<dynamic> json = jsonDecode(response.body);
  return json.map((item) => RankingData(
    rank: item['rank'],
    line: item['line'],
    incidents: item['incidents'],
  )).toList();
}

Future<void> submitIncident(IncidentData incident) async {
  await http.post(
    Uri.parse('api/incidents'),
    body: jsonEncode(incident.toJson()),
    headers: {'Content-Type': 'application/json'},
  );
}
```

## Testing Guidelines

### Widget Tests
```dart
testWidgets('StampedButton is disabled when onPressed is null', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.darkTheme,
      home: Scaffold(
        body: StampedButton(
          onPressed: null,
          icon: Icons.add,
          label: 'TEST',
        ),
      ),
    ),
  );
  
  expect(find.text('TEST'), findsOneWidget);
});
```

### Unit Tests
```dart
test('RankingData stores values correctly', () {
  final data = RankingData(rank: 1, line: '7', incidents: 18);
  
  expect(data.rank, 1);
  expect(data.line, '7');
  expect(data.incidents, 18);
});
```

## Troubleshooting

### Common Issues

**Fonts not displaying**
- Ensure fonts are in `assets/fonts/`
- Check pubspec.yaml font declarations
- Run `flutter clean` and rebuild

**Theme colors not working**
- Always use `Theme.of(context).colorScheme.*`
- Never use hardcoded Color values
- Wrap widget tree with MaterialApp or Theme

**Custom painter not rendering**
- Check CustomPainter `shouldRepaint` method
- Ensure paint operations are within canvas bounds
- Verify painter is assigned to CustomPaint widget

**Button not responding**
- Check if `onPressed` is null (disabled state)
- Verify GestureDetector is not blocked
- Check widget tree for blocking overlays

## Performance Considerations

### Optimization Tips
1. Use `const` constructors when possible
2. Avoid rebuilding entire widget tree
3. Use `ListView.builder` for long lists
4. Cache computed values
5. Minimize setState scope
6. Use `RepaintBoundary` for complex widgets

### Memory Management
1. Dispose controllers in `dispose()` method
2. Remove listeners before disposal
3. Cancel streams and timers
4. Clear large collections when not needed

## Accessibility

### Best Practices
1. Provide semantic labels for icons
2. Ensure sufficient color contrast
3. Support screen readers
4. Use meaningful button labels
5. Provide text alternatives for visual elements

## Platform-Specific Notes

### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: Latest stable
- Material 3 design
- Edge-to-edge display support

### iOS
- Minimum iOS version: 12.0
- SafeArea handling for notch/island
- Platform-specific navigation patterns
- Haptic feedback support

## Localization

Currently hardcoded in Polish. For internationalization:

```dart
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.0
```

```dart
return MaterialApp(
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('pl', 'PL'),
    Locale('en', 'US'),
  ],
);
```

## Design System Summary

### Spacing Scale
- 4px: Minimal spacing
- 8px: Small spacing
- 12px: Medium spacing
- 16px: Standard padding
- 24px: Large spacing

### Border Widths
- 1px: Category tags
- 2px: Input fields, ranking entries, header/footer borders
- 3px: Statement frames, stamped button
- 4px: Verification frame, wanted border

### Icon Sizes
- 24px: Standard icons
- 28px: App bar icons
- 32px: Dropdown arrow

### Corner Radius
- 0px: All elements (square corners only)

This documentation provides complete context for AI agents to understand and work with the Trammageddon Flutter application.
