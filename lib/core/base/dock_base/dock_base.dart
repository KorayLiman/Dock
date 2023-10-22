import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

/// DOCK ABSTRACT BASE CLASS
abstract base class DockBase {
  /// [WidgetsBinding] instance
  WidgetsBinding get widgetsBinding => testBindings ?? WidgetsFlutterBinding.ensureInitialized();

  /// [WidgetsBinding] only for testing
  @visibleForTesting
  WidgetsBinding? testBindings;

  /// Default on loading widget builder
  WidgetCallback? defaultOnLoadingWidgetBuilder;

  ///  Default on empty widget builder
  WidgetCallback? defaultOnEmptyWidgetBuilder;

  ///  Default on error widget builder
  WidgetCallback? defaultOnErrorWidgetBuilder;

  ///  Default on offline widget builder
  WidgetCallback? defaultOnOfflineWidgetBuilder;
}
