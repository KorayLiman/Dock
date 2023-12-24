import 'package:flutter/material.dart';

/// DOCK ABSTRACT BASE CLASS
abstract base class DockBase {
  /// [WidgetsBinding] instance
  WidgetsBinding get widgetsBinding => testBindings ?? WidgetsFlutterBinding.ensureInitialized();

  /// [WidgetsBinding] only for testing
  @visibleForTesting
  WidgetsBinding? testBindings;

  /// Default on loading widget builder
  WidgetBuilder? defaultOnLoadingWidgetBuilder;

  /// Default on empty widget builder
  WidgetBuilder? defaultOnEmptyWidgetBuilder;

  /// Default on error widget builder
  WidgetBuilder? defaultOnErrorWidgetBuilder;

  /// Default on offline widget builder
  WidgetBuilder? defaultOnOfflineWidgetBuilder;
}
