import 'package:dock_flutter/src/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// DOCK ABSTRACT BASE CLASS
abstract base class DockBase {
  /// [WidgetsBinding] instance
  WidgetsBinding get widgetsBinding => testBindings ?? WidgetsFlutterBinding.ensureInitialized();

  /// [WidgetsBinding] only for testing
  @visibleForTesting
  WidgetsBinding? testBindings;

  /// Default on loading widget builder
  ViewStateCallback? defaultOnLoadingWidgetBuilder;

  /// Default on empty widget builder
  ViewStateCallback? defaultOnEmptyWidgetBuilder;

  /// Default on error widget builder
  ViewStateCallback? defaultOnErrorWidgetBuilder;

  /// Default on offline widget builder
  ViewStateCallback? defaultOnOfflineWidgetBuilder;

  SchedulerBinding get schedulerBinding => SchedulerBinding.instance;
}
