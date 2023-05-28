import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData themeData() {
    const primaryColor = Color(0xFF00B894); // Cor primária desejada

    // Crie uma paleta de cores usando a cor primária
    final MaterialColor primarySwatch = MaterialColor(
      primaryColor.value,
      <int, Color>{
        50: primaryColor.withOpacity(0.1),
        100: primaryColor.withOpacity(0.2),
        200: primaryColor.withOpacity(0.3),
        300: primaryColor.withOpacity(0.4),
        400: primaryColor.withOpacity(0.5),
        500: primaryColor.withOpacity(0.6),
        600: primaryColor.withOpacity(0.7),
        700: primaryColor.withOpacity(0.8),
        800: primaryColor.withOpacity(0.9),
        900: primaryColor.withOpacity(1.0),
      },
    );

    return ThemeData(
      primarySwatch: primarySwatch,
    );
  }
}
