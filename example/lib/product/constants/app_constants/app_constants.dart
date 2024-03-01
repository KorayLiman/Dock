import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  static const themeConstants = ThemeConstants._();
  static const appBuildType = AppBuildType._();
}

@immutable
final class ThemeConstants {
  const ThemeConstants._();

  ThemeData get light => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      );
}

@immutable
final class AppBuildType {
  const AppBuildType._();

  BuildType get type => BuildType.test;
}
