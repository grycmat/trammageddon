import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentRed,
        onPrimary: AppColors.pureBlack,
        primaryContainer: AppColors.distressRed,
        onPrimaryContainer: AppColors.pureWhite,
        secondary: AppColors.distressRed,
        onSecondary: AppColors.pureBlack,
        secondaryContainer: AppColors.accentRed,
        onSecondaryContainer: AppColors.pureWhite,
        tertiary: AppColors.tagInactive,
        onTertiary: AppColors.pureWhite,
        tertiaryContainer: AppColors.tagBorder,
        onTertiaryContainer: AppColors.pureWhite,
        surface: AppColors.backgroundOverlay,
        onSurface: AppColors.pureWhite,
        onSurfaceVariant: AppColors.textGray,
        error: AppColors.distressRed,
        onError: AppColors.pureWhite,
        errorContainer: AppColors.accentRed,
        onErrorContainer: AppColors.pureBlack,
        outline: AppColors.pureWhite,
        outlineVariant: AppColors.tagBorder,
        scrim: AppColors.pureBlack,
        inverseSurface: AppColors.pureWhite,
        onInverseSurface: AppColors.pureBlack,
        inversePrimary: AppColors.accentRed,
        surfaceTint: AppColors.accentRed,
      ),
      scaffoldBackgroundColor: AppColors.pureBlack,
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: AppColors.accentRed, size: 24),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.pureBlack,
        foregroundColor: AppColors.pureWhite,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.accentRed, size: 24),
      ),
      cardTheme: CardThemeData(
        color: AppColors.backgroundOverlay,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: AppColors.pureWhite, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.distressRed,
          foregroundColor: AppColors.pureBlack,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: AppColors.pureBlack, width: 3),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.pureWhite,
          side: const BorderSide(color: AppColors.pureWhite, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.tagInactive,
        selectedColor: AppColors.accentRed,
        disabledColor: AppColors.tagInactive,
        labelStyle: const TextStyle(
          fontFamily: 'ChivoMono',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.pureWhite,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'ChivoMono',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.pureBlack,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: AppColors.tagBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundOverlay,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: AppColors.pureWhite, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: AppColors.pureWhite, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: AppColors.accentRed, width: 2),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accentRedLight,
        onPrimary: AppColors.pureWhite,
        primaryContainer: AppColors.distressRedLight,
        onPrimaryContainer: AppColors.pureWhite,
        secondary: AppColors.distressRedLight,
        onSecondary: AppColors.pureWhite,
        secondaryContainer: AppColors.accentRedLight,
        onSecondaryContainer: AppColors.pureWhite,
        tertiary: AppColors.lightTagInactive,
        onTertiary: AppColors.darkGray,
        tertiaryContainer: AppColors.lightTagBorder,
        onTertiaryContainer: AppColors.mediumGray,
        surface: AppColors.lightSurface,
        onSurface: AppColors.darkGray,
        onSurfaceVariant: AppColors.lightGray,
        error: AppColors.distressRedLight,
        onError: AppColors.pureWhite,
        errorContainer: AppColors.accentRedLight,
        onErrorContainer: AppColors.pureWhite,
        outline: AppColors.mediumGray,
        outlineVariant: AppColors.lightBorder,
        scrim: AppColors.pureBlack,
        inverseSurface: AppColors.darkGray,
        onInverseSurface: AppColors.lightBackground,
        inversePrimary: AppColors.accentRedLight,
        surfaceTint: AppColors.accentRedLight,
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: AppColors.accentRedLight, size: 24),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        foregroundColor: AppColors.darkGray,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.accentRedLight, size: 24),
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: AppColors.mediumGray, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.distressRedLight,
          foregroundColor: AppColors.pureWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
            side: const BorderSide(color: AppColors.mediumGray, width: 3),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkGray,
          side: const BorderSide(color: AppColors.mediumGray, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightTagInactive,
        selectedColor: AppColors.accentRedLight,
        disabledColor: AppColors.lightTagInactive,
        labelStyle: const TextStyle(
          fontFamily: 'ChivoMono',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.darkGray,
        ),
        secondaryLabelStyle: const TextStyle(
          fontFamily: 'ChivoMono',
          fontWeight: FontWeight.w700,
          fontSize: 12,
          color: AppColors.pureWhite,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: const BorderSide(color: AppColors.lightTagBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSurfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: AppColors.mediumGray, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(color: AppColors.lightBorder, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: AppColors.accentRedLight,
            width: 2,
          ),
        ),
      ),
    );
  }

  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 57,
      height: 1.12,
      letterSpacing: -0.25,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 45,
      height: 1.16,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 36,
      height: 1.22,
      letterSpacing: 0,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 32,
      height: 1.25,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 28,
      height: 1.29,
      letterSpacing: 0,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 1.27,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Oswald',
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w700,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontFamily: 'ChivoMono',
      fontWeight: FontWeight.w400,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.5,
    ),
  );
}
