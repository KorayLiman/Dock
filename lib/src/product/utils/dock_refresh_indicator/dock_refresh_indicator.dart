import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// A smart [RefreshIndicator] with autoRebuild feature.
class DockRefreshIndicator extends StatelessWidget {
  const DockRefreshIndicator({
    required this.child,
    required this.onRefresh,
    super.key,
    this.autoRebuild = true,
    this.indicatorStateKey,
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

  /// Child widget.
  final Widget child;

  /// Whether to auto rebuild the widget after refresh.
  final bool autoRebuild;

  /// The key of the refresh indicator state.
  final GlobalKey<RefreshIndicatorState>? indicatorStateKey;

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

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await onRefresh();
        if (autoRebuild) {
          Dock.safeMarkNeedsBuild(context as Element);
        }
      },
      key: indicatorStateKey,
      color: color,
      backgroundColor: backgroundColor,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      notificationPredicate: notificationPredicate,
      displacement: displacement,
      edgeOffset: edgeOffset,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
      child: autoRebuild
          ? KeyedSubtree(
              key: UniqueKey(),
              child: child,
            )
          : child,
    );
  }
}
