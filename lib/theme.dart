import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      scaffoldBackgroundColor: const Color(0xFFFBFBF4),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.raleway(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleMedium: GoogleFonts.dancingScript(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.raleway(
          fontSize: 16,
          color: Colors.black87,
        ),
        labelLarge: GoogleFonts.raleway(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFBFBF4),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}
