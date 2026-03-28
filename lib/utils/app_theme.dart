import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary       = Color(0xFF0D1B3E);
  static const Color primaryDark   = Color(0xFF08111F);
  static const Color accent        = Color(0xFFC9A84C);
  static const Color background    = Color(0xFFF5F0E8);
  static const Color surface       = Color(0xFFFFFFFF);
  static const Color inputFill     = Color(0xFFEEEBE3);
  static const Color textPrimary   = Color(0xFF0D1B3E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color error         = Color(0xFFD32F2F);
  static const Color success       = Color(0xFF2E7D32);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary:          primary,
      onPrimary:        Colors.white,
      primaryContainer: Color(0xFF1A2F5E),
      onPrimaryContainer: Colors.white,
      secondary:        accent,
      onSecondary:      Colors.white,
      secondaryContainer: Color(0xFFFFF3D6),
      onSecondaryContainer: primary,
      surface:          surface,
      onSurface:        textPrimary,
      error:            error,
      onError:          Colors.white,
    ),
    scaffoldBackgroundColor: background,

    appBarTheme: AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.lora(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        textStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: inputFill,
      hintStyle: TextStyle(color: textSecondary, fontSize: 14),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFD1C9B8), width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFFD1C9B8), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: error, width: 2),
      ),
    ),

    cardTheme: CardThemeData(
      color: surface,
      elevation: 2,
      shadowColor: primary.withOpacity(0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Color(0xFFE2D9C8), width: 1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accent,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: primary,
      contentTextStyle: TextStyle(color: Colors.white, fontSize: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: primary,
    ),

    dividerTheme: DividerThemeData(
      color: Color(0xFFE2D9C8),
      thickness: 1,
    ),

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.bold, color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 22, fontWeight: FontWeight.w600, color: textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w600, color: textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: textPrimary,
      ),
      bodyLarge: TextStyle(fontSize: 15, color: textPrimary),
      bodyMedium: TextStyle(fontSize: 13, color: textSecondary),
      labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w600, color: textPrimary,
      ),
    ),
  );
}