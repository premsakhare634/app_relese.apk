import 'package:flutter/material.dart';

class AppTheme {
  static const cream = Color(0xFFF8F5ED);
  static const surface = Color(0xFFFFFDF8);
  static const green = Color(0xFF173F35);
  static const green2 = Color(0xFF285C4D);
  static const gold = Color(0xFFC9A227);
  static const softGold = Color(0xFFE4D39A);
  static const text = Color(0xFF1C2824);
  static const secondary = Color(0xFF68736E);
  static const muted = Color(0xFF8B938F);
  static const border = Color(0xFFE6E0D3);

  static ThemeData light() => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: cream,
    colorScheme: ColorScheme.fromSeed(seedColor: green),
    appBarTheme: const AppBarTheme(backgroundColor: cream, foregroundColor: text, elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: border)),
    ),
    cardTheme: CardThemeData(
      color: surface, elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: border)),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: surface, indicatorColor: softGold,
    ),
  );
}
