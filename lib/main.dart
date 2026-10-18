import 'package:flutter/material.dart';

import 'screens/step_one_screen.dart';

void main() {
  runApp(const InscriptionApp());
}

class InscriptionApp extends StatelessWidget {
  const InscriptionApp({super.key});

  static const primary = Color(0xFF00A8CC);
  static const error = Color(0xFFD32F2F);
  static const fieldBackground = Color(0xFFF2F7F9);

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      error: error,
      surface: Colors.white,
    );

    final rayon = BorderRadius.circular(8);

    return MaterialApp(
      title: 'TP8 Inscription',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: fieldBackground,
          labelStyle: const TextStyle(fontSize: 14),
          helperStyle: const TextStyle(fontSize: 12),
          errorStyle: const TextStyle(fontSize: 12),
          errorMaxLines: 3,
          border: OutlineInputBorder(borderRadius: rayon),
          enabledBorder: OutlineInputBorder(
            borderRadius: rayon,
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: rayon,
            borderSide: const BorderSide(
              color: primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: rayon,
            borderSide: const BorderSide(color: error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: rayon,
            borderSide: const BorderSide(
              color: error,
              width: 2,
            ),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: const StadiumBorder(),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            shape: const StadiumBorder(),
          ),
        ),
      ),
      home: const StepOneScreen(),
    );
  }
}