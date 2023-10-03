import 'package:flutter/material.dart';

/// [BuildContext] EXTENSION
extension ContextExtension on BuildContext {
  /// Equivalent to MediaQuery.sizeOf(this)
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  /// Equivalent to MediaQuery.sizeOf(this).height
  double get height => mediaQuerySize.height;

  /// Equivalent to MediaQuery.sizeOf(this).width
  double get width => mediaQuerySize.width;

  /// Equivalent to Theme.of(this)
  ThemeData get theme => Theme.of(this);

  /// Equivalent to Theme.of(this).brightness == Brightness.dark
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Equivalent to Theme.of(this).textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Equivalent to MediaQuery.paddingOf(this)
  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);

  /// Equivalent to MediaQuery.of(this)
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Equivalent to MediaQuery.viewPaddingOf(this)
  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  /// Equivalent to MediaQuery.viewInsetsOf(this)
  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  /// Equivalent to MediaQuery.orientationOf(this)
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Equivalent to MediaQuery.orientationOf(this) == Orientation.landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Equivalent to MediaQuery.orientationOf(this) == Orientation.portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Equivalent to MediaQuery.devicePixelRatioOf(this)
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Equivalent to MediaQuery.textScaleFactorOf(this)
  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  /// Equivalent to MediaQuery.sizeOf(this).shortestSide
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// Equivalent to MediaQuery.sizeOf(this).shortestSide < 600
  bool get isPhone => mediaQueryShortestSide < 600;

  /// Equivalent to MediaQuery.sizeOf(this).shortestSide >=  600
  bool get isTablet => mediaQueryShortestSide >= 600;

  // Todo  requires detailed test
  /// Close keyboard if open
  void closeKeyboard() {
    if (FocusManager.instance.primaryFocus?.hasFocus ?? false || View.of(this).viewInsets.bottom > 0.0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
