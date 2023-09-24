// ignore_for_file: prefer_constructors_over_static_methods

import 'package:flutter/material.dart';

abstract class AppConstants {
  AppConstants._();

  static final themeConstants = _ThemeConstants.instance;
}

@immutable
class _ThemeConstants {
  _ThemeConstants._();
  static _ThemeConstants? _instance;

  static _ThemeConstants get instance => _instance ??= _ThemeConstants._();

  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.deepPurple,
  );
}
