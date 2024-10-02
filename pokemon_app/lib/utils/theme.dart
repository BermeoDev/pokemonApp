import 'package:flutter/services.dart';
import 'package:flutter/material.dart'; 


class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        color: Colors.red,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark, // Controla el brillo de la barra de estado.
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // 
          foregroundColor: Colors.white, // 
        ),
      ),
    );
  }
}