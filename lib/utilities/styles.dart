import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.jost(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.jost(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.jost(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.jost(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline4: GoogleFonts.jost(
      fontSize: 13.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.jost(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.jost(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.jost(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.jost(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.jost(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.jost(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  static ThemeData light(context) {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: GoogleFonts.jostTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static ThemeData dark(context) {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: GoogleFonts.jostTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }
}
