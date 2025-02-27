import 'package:flutter/material.dart';
import 'colors.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  textTheme: TextTheme(
    titleLarge: TextStyle(color: AppColors.text, fontSize: 24),
    bodyMedium: TextStyle(color: AppColors.text, fontSize: 16),
  ),
);
