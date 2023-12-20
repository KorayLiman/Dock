import 'package:flutter/material.dart';

/// A pull to refresh configuration of StateBuilder.
final class RefreshConfig {
  const RefreshConfig.pullToRefresh({
    required this.onRefresh,
    this.key,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    this.strokeWidth = RefreshProgressIndicator.defaultStrokeWidth,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  /// The key of the refresh indicator state.
  final GlobalKey<RefreshIndicatorState>? key;

  /// The color of the refresh indicator.
  final Color? color;

  /// The background color of the refresh indicator.
  final Color? backgroundColor;

  /// The semantics label of the refresh indicator.
  final String? semanticsLabel;

  /// The semantics value of the refresh indicator.
  final String? semanticsValue;

  /// The refresh logic.
  final Future<void> Function() onRefresh;

  /// The displacement of the refresh indicator.
  final double displacement;

  /// The edge offset of the refresh indicator.
  final double edgeOffset;

  /// The notification predicate of the refresh indicator.
  final bool Function(ScrollNotification) notificationPredicate;

  /// The stroke width of the refresh indicator.
  final double strokeWidth;

  /// The trigger mode of the refresh indicator.
  final RefreshIndicatorTriggerMode triggerMode;
}
