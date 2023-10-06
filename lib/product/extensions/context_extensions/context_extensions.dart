import 'dart:ui';

import 'package:flutter/material.dart';

/// [BuildContext] EXTENSION
extension ContextExtension on BuildContext {
  /// Equivalent to MediaQuery.sizeOf(context)
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  /// Equivalent to MediaQuery.sizeOf(context).height
  double get height => mediaQuerySize.height;

  /// Equivalent to MediaQuery.sizeOf(context).width
  double get width => mediaQuerySize.width;

  /// Equivalent to Theme.of(context)
  ThemeData get theme => Theme.of(this);

  /// Equivalent to Theme.of(context).brightness == Brightness.dark
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Equivalent to Theme.of(context).textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Equivalent to MediaQuery.paddingOf(context)
  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);

  /// Equivalent to MediaQuery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Equivalent to MediaQuery.viewPaddingOf(context)
  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  /// Equivalent to MediaQuery.viewInsetsOf(context)
  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  /// Equivalent to MediaQuery.orientationOf(context)
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Equivalent to MediaQuery.orientationOf(context) == Orientation.landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Equivalent to MediaQuery.orientationOf(context) == Orientation.portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Equivalent to MediaQuery.devicePixelRatioOf(context)
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Equivalent to MediaQuery.textScaleFactorOf(context)
  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide < 600
  bool get isPhone => mediaQueryShortestSide < 600;

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide >=  600
  bool get isTablet => mediaQueryShortestSide >= 600;

  /// Equivalent to View.of(context)
  FlutterView get view => View.of(this);

  /// Checks if keyboard is open
  bool get isKeyboardOpen => FocusManager.instance.primaryFocus?.hasFocus ?? false || view.viewInsets.bottom > 0.0;

  /// Closes keyboard if open
  void closeKeyboard() {
    if (isKeyboardOpen) FocusManager.instance.primaryFocus?.unfocus();
  }
}
