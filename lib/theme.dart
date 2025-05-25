import 'package:flutter/material.dart';

// Cores do Aplicativo
class AppColors {
  static const Color background = Color(0xFFDDEDE4);
  static const Color button = Color(0xFF204F3D);
  static const Color buttonText = Colors.white;
  static const Color primaryText = Color(0xFF26483A);
  static const Color secondaryText = Color(0xFF737373,); // Adicionei a cor secondaryText
  static const Color heartRed = Color(0xFFC82828);
  static const Color shadow = Color(0xFFCCDED5);
  static const Color accessibilityIcon = Color(0xFF436B56);
  static const Color skinTone = Color(0xFFF7D8BF);
   
}


// Tema do Aplicativo
class AppTheme {
  static Color background(BuildContext context) => 
      Theme.of(context).brightness == Brightness.dark 
      ? Colors.grey[900]! 
      : Colors.white;
      
  static Color primaryText(BuildContext context) => 
      Theme.of(context).brightness == Brightness.dark 
      ? Colors.white 
      : Colors.black;
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Nunito', // Use a fonte Nunito
    splashColor: AppColors.button,
    highlightColor: AppColors.button,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.button,
      selectionColor: Color(0xFFB0D9CE),
      selectionHandleColor: AppColors.button,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: AppColors.button),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.primaryText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(color: AppColors.primaryText, fontSize: 16),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.button,
        foregroundColor: AppColors.buttonText,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.shadow),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.shadow),
      ),
      focusedBorder: OutlineInputBorder(),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.heartRed),
      ),
    ),
  );
}
