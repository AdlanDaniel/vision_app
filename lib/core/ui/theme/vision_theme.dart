import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vision_app/core/ui/theme/vision_colors.dart';
import 'package:vision_app/core/utils/sizes/sizes.dart';

class VisionTheme {
  VisionTheme._();

  static ThemeData get darkTheme => ThemeData(
    scaffoldBackgroundColor: VisionColors.background,
    primaryColor: VisionColors.primary,
    iconTheme: _iconThemeData(),
    appBarTheme: _appBarThemeData(),
    elevatedButtonTheme: _elevatedButtonThemeData(),
    textButtonTheme: _textButtonThemeData(),
    inputDecorationTheme: _inputDecorationTheme(),
    textSelectionTheme: _textSelectionTheme(),
    textTheme: _textTheme(),
    dividerTheme: _dividerTheme(),

    progressIndicatorTheme: _progressIndicatorTheme(),
  );

  static IconThemeData _iconThemeData() =>
      const IconThemeData(size: VisionSizes.mediumM14);

  static AppBarTheme _appBarThemeData() => AppBarTheme(
    backgroundColor: VisionColors.background,
    iconTheme: IconThemeData(
      size: VisionSizes.mediumM22,
      color: VisionColors.primary,
    ),
  );

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: VisionColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(VisionSizes.smallS8),
          ),
        ),
      );

  static TextButtonThemeData _textButtonThemeData() => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: VisionColors.onPrimary,
      textStyle: const TextStyle(
        fontSize: VisionSizes.mediumM14,
        fontWeight: FontWeight.w600,
        letterSpacing: VisionSizes.mediumM14 * 0.02,
        height: 1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(VisionSizes.smallS8),
      ),
    ),
  );

  static InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.never,

    labelStyle: TextStyle(
      fontSize: VisionSizes.mediumM14,
      color: VisionColors.onSecondary,
    ),
    hintStyle: TextStyle(
      color: VisionColors.onSecondary,
      fontSize: VisionSizes.mediumM14,
      fontWeight: FontWeight.w400,
      height: 1,
      letterSpacing: VisionSizes.mediumM14 * 0.05,
    ),
    errorStyle: TextStyle(
      fontSize: VisionSizes.mediumM12,
      color: VisionColors.error,
    ),
    suffixIconColor: VisionColors.onSecondary,
    suffixStyle: TextStyle(
      fontSize: VisionSizes.mediumM14,
      color: VisionColors.onSecondary,
    ),
    prefixIconColor: VisionColors.onSecondary,
    prefixStyle: TextStyle(
      fontSize: VisionSizes.mediumM14,
      color: VisionColors.onSecondary,
    ),

    isDense: true,
    fillColor: VisionColors.secondary,

    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VisionSizes.smallS8)),
      borderSide: BorderSide(
        color: VisionColors.onSecondary,
        width: VisionSizes.smallS1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VisionSizes.smallS8)),
      borderSide: BorderSide(
        color: VisionColors.onSecondary,
        width: VisionSizes.smallS1,
      ),
    ),
    filled: true,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VisionSizes.smallS8)),
      borderSide: BorderSide(
        color: VisionColors.onSecondary,
        width: VisionSizes.smallS1,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VisionSizes.smallS8)),
      borderSide: BorderSide(
        color: VisionColors.error,
        width: VisionSizes.smallS1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VisionSizes.smallS8)),
      borderSide: BorderSide(
        color: VisionColors.error,
        width: VisionSizes.smallS1,
      ),
    ),
  );

  static TextSelectionThemeData _textSelectionTheme() =>
      const TextSelectionThemeData(cursorColor: VisionColors.onBackground);

  static ProgressIndicatorThemeData _progressIndicatorTheme() =>
      ProgressIndicatorThemeData(color: VisionColors.onPrimary);

  static TextTheme? _textTheme() => GoogleFonts.epilogueTextTheme(
    const TextTheme(
      bodyLarge: TextStyle(
        color: VisionColors.onBackground,
        fontSize: VisionSizes.largeL32,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: VisionSizes.mediumM14 * 0.015,
      ),
      bodyMedium: TextStyle(
        color: VisionColors.onBackground,
        fontSize: VisionSizes.mediumM14,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      ),
      bodySmall: TextStyle(
        color: VisionColors.onBackground,
        fontSize: VisionSizes.mediumM12,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      ),
      titleLarge: TextStyle(
        color: VisionColors.onSecondary,
        fontSize: VisionSizes.mediumM12 * 1.5,
        fontWeight: FontWeight.w600,
        height: 1,
        letterSpacing: VisionSizes.mediumM14 * 0.05,
      ),
      titleMedium: TextStyle(
        color: VisionColors.onSecondary,
        fontSize: VisionSizes.mediumM14,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: 0,
      ),
      titleSmall: TextStyle(
        color: VisionColors.onSecondary,
        fontSize: VisionSizes.mediumM12,
        fontWeight: FontWeight.w400,
        height: 1,
        letterSpacing: VisionSizes.mediumM14 * 0.005,
      ),
    ),
  );

  static DividerThemeData _dividerTheme() => DividerThemeData(
    color: VisionColors.onSurface.withValues(alpha: .2),
    thickness: VisionSizes.smallS1,
  );
}
