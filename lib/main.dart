import "package:flutter/material.dart";
import "package:prac7/features/habits/presentation/screens/auth_screen.dart";

void main() {
  runApp(const HabitsApp());
}

class HabitsApp extends StatelessWidget {
  const HabitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4C6EF5),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: "Habit Tracker",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.onSurface,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        chipTheme: ChipThemeData(
          shape: const StadiumBorder(),
          backgroundColor: colorScheme.surfaceContainerHighest,
          selectedColor: colorScheme.primary,
          labelStyle: TextStyle(color: colorScheme.onSurface),
        ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: "Roboto",
              bodyColor: colorScheme.onSurface,
              displayColor: colorScheme.onSurface,
            ),
      ),
      home: const AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
