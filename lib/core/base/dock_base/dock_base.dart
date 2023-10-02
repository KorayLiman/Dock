import 'package:flutter/material.dart';

typedef WidgetCallback = Widget Function();

/// DOCK ABSTRACT BASE CLASS
abstract base class DockBase {
  /// [WidgetsBinding] instance
  WidgetsBinding get widgetsBinding => WidgetsBinding.instance;

  /// Default on loading widget builder
  WidgetCallback? defaultOnLoadingWidgetBuilder;

  ///  Default on empty widget builder
  WidgetCallback? defaultOnEmptyWidgetBuilder;

  ///  Default on error widget builder
  WidgetCallback? defaultOnErrorWidgetBuilder;

  ///  Default on offline widget builder
  WidgetCallback? defaultOnOfflineWidgetBuilder;
}
