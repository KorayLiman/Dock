// ignore_for_file: prefer_constructors_over_static_methods

import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  AppConstants._();

  static final themeConstants = _ThemeConstants.instance;
  static final appBuildType = _AppBuildType.instance;
}

@immutable
final class _ThemeConstants {
  _ThemeConstants._();

  static _ThemeConstants? _instance;

  static _ThemeConstants get instance => _instance ??= _ThemeConstants._();

  final ThemeData material3 = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.deepPurple,
  );
  final ThemeData material2 = ThemeData(
    useMaterial3: false,
  );
}

final class _AppBuildType {
  _AppBuildType._();

  static _AppBuildType? _instance;

  static _AppBuildType get instance => _instance ??= _AppBuildType._();

  final BuildType type = BuildType.test;
}
