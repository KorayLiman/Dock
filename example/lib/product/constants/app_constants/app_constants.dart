// ignore_for_file: prefer_constructors_over_static_methods

import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  static final themeConstants = _ThemeConstants.instance;
  static final appBuildType = _AppBuildType.instance;
}

@immutable
final class _ThemeConstants {
  const _ThemeConstants._();

  static _ThemeConstants? _instance;

  static _ThemeConstants get instance => _instance ??= const _ThemeConstants._();

  ThemeData get light => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      );
}

@immutable
final class _AppBuildType {
  const _AppBuildType._();

  static _AppBuildType? _instance;

  static _AppBuildType get instance => _instance ??= const _AppBuildType._();

  BuildType get type => BuildType.test;
}
