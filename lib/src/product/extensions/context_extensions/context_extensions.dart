import 'dart:ui';

import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

/// [BuildContext] EXTENSION
extension ContextExtension on BuildContext {
  /// All of the methods in [Dependency] creates a dependency on [InheritedWidget] or [InheritedModel]
  ///
  /// When a dependency above changes, the caller widget will be rebuilt.
  Dependency get dependOn => Dependency._get(this);

  // TODO(KorayLiman): This is experimental. Needs to be tested and also be considered if it's useful or not.
  /// Rebuilds widget with given context in the next frame
  @experimental
  void rebuildWidget() => Dock.safeMarkNeedsBuild(this as Element);

  // TODO(KorayLiman): We need to see if depending is necessary
  // void closeKeyboard() {
  //   if (dependOn.isKeyboardOpen) FocusManager.instance.primaryFocus?.unfocus();
  // }

  /// Closes keyboard
  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

/// A class that all it's methods create dependency on [InheritedWidget] or [InheritedModel]
final class Dependency {
  Dependency._(this.context);

  factory Dependency._get(BuildContext context) {
    if (_instance.isNull) {
      _instance = Dependency._(context);
    } else {
      _instance!.context = context;
    }
    return _instance!;
  }

  static Dependency? _instance;

  BuildContext context;

  /// Equivalent to MediaQuery.sizeOf(context)
  Size get mediaQuerySize => MediaQuery.sizeOf(context);

  /// Equivalent to MediaQuery.sizeOf(context).height
  double get height => mediaQuerySize.height;

  /// Equivalent to MediaQuery.sizeOf(context).width
  double get width => mediaQuerySize.width;

  /// Equivalent to Theme.of(context)
  ThemeData get theme => Theme.of(context);

  /// Equivalent to Theme.of(context).brightness == Brightness.dark
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Equivalent to Theme.of(context).textTheme
  TextTheme get textTheme => Theme.of(context).textTheme;

  /// Equivalent to MediaQuery.paddingOf(context)
  EdgeInsets get mediaQueryPadding => MediaQuery.paddingOf(context);

  /// Equivalent to MediaQuery.of(context)
  MediaQueryData get mediaQuery => MediaQuery.of(context);

  /// Equivalent to MediaQuery.viewPaddingOf(context)
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(context);

  /// Equivalent to MediaQuery.viewInsetsOf(context)
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(context);

  /// Equivalent to MediaQuery.orientationOf(context)
  Orientation get orientation => MediaQuery.orientationOf(context);

  /// Equivalent to MediaQuery.orientationOf(context) == Orientation.landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// Equivalent to MediaQuery.orientationOf(context) == Orientation.portrait
  bool get isPortrait => orientation == Orientation.portrait;

  /// Equivalent to MediaQuery.devicePixelRatioOf(context)
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(context);

  /// Equivalent to MediaQuery.textScalerOf(context)
  TextScaler get textScaler => MediaQuery.textScalerOf(context);

  /// Equivalent to Directionality.of(context)
  TextDirection get directionality => Directionality.of(context);

  /// Equivalent to DefaultTextStyle.of(context)
  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(context);

  /// Equivalent to MediaQuery.boldTextOf(context)
  bool get usingBoldText => MediaQuery.boldTextOf(context);

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide < 600
  bool get isPhone => mediaQueryShortestSide < 600;

  /// Equivalent to MediaQuery.sizeOf(context).shortestSide >=  600
  bool get isTablet => mediaQueryShortestSide >= 600;

  /// Equivalent to View.of(context)
  FlutterView get flutterView => View.of(context);

  /// Equivalent to Localizations.localeOf(context)
  Locale get locale => Localizations.localeOf(context);

  /// Equivalent to Localizations.maybeLocaleOf(context)
  Locale? get maybeLocale => Localizations.maybeLocaleOf(context);

  /// Checks if keyboard is open
  bool get isKeyboardOpen => FocusManager.instance.primaryFocus?.hasFocus ?? false || flutterView.viewInsets.bottom > 0.0;
}
