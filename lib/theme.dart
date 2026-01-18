import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color accentRed = Color(0xFFE53935);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,

  // Core colors
  primaryColor: accentRed,
  colorScheme: ColorScheme.fromSeed(
    seedColor: accentRed,
    brightness: Brightness.light,
  ),

  // Backgrounds
  scaffoldBackgroundColor: Colors.white,

  // Text
  textTheme: GoogleFonts.poppinsTextTheme(
    const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    ),
  ),

  // Buttons
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: accentRed,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
);
