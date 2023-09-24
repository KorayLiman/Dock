import 'package:flutter/material.dart';

extension ContextExtensionss on BuildContext {
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  double get height => mediaQuerySize.height;

  double get width => mediaQuerySize.width;

  ThemeData get theme => Theme.of(this);

  bool get isDarkMode => theme.brightness == Brightness.dark;

  TextTheme get textTheme => Theme.of(this).textTheme;

  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  EdgeInsets get mediaQueryViewPadding => MediaQuery.viewPaddingOf(this);

  EdgeInsets get mediaQueryViewInsets => MediaQuery.viewInsetsOf(this);

  Orientation get orientation => MediaQuery.orientationOf(this);

  bool get isLandscape => orientation == Orientation.landscape;

  bool get isPortrait => orientation == Orientation.portrait;

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  double get textScaleFactor => MediaQuery.textScaleFactorOf(this);

  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  bool get isPhone => mediaQueryShortestSide < 600;

  bool get isTablet => mediaQueryShortestSide >= 600;

  //KEYBOARD

  void turnOffKeyboard() {
    if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
