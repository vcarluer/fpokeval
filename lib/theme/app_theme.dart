import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const pokemonRed = Color(0xFFFF0000);
  static const pokemonDarkRed = Color(0xFFCC0000);

  static ThemeData lightTheme = ThemeData(
    primaryColor: pokemonRed,
    colorScheme: ColorScheme.fromSeed(
      seedColor: pokemonRed,
      primary: pokemonRed,
      secondary: pokemonDarkRed,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.getFont(
        'Pokemon',
        color: pokemonRed,
        fontSize: 48,
        shadows: [
          const Shadow(
            offset: Offset(3.0, 3.0),
            blurRadius: 0,
            color: Colors.black,
          ),
        ],
      ),
      bodyLarge: GoogleFonts.roboto(),
      bodyMedium: GoogleFonts.roboto(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.black, width: 2),
      ),
    ),
  );
}