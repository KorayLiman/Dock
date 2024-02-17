import 'dart:async';

import 'package:flutter/material.dart';

/// A smart [RefreshIndicator] with autoRebuild feature.
class DockRefreshIndicator extends StatefulWidget {
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
  final FutureOr<void> Function() onRefresh;

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
  State<DockRefreshIndicator> createState() => _DockRefreshIndicatorState();
}

class _DockRefreshIndicatorState extends State<DockRefreshIndicator> {
  var _key = UniqueKey();

  void _renewKey() {
    _key = UniqueKey();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async {
        await widget.onRefresh();
        if (widget.autoRebuild) {
          setState(_renewKey);
        }
      },
      key: widget.indicatorStateKey,
      color: widget.color,
      backgroundColor: widget.backgroundColor,
      semanticsLabel: widget.semanticsLabel,
      semanticsValue: widget.semanticsValue,
      notificationPredicate: widget.notificationPredicate,
      displacement: widget.displacement,
      edgeOffset: widget.edgeOffset,
      strokeWidth: widget.strokeWidth,
      triggerMode: widget.triggerMode,
      child: KeyedSubtree(
        key: _key,
        child: widget.child,
      ),
    );
  }
}
