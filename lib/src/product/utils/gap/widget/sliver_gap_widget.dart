import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// An empty widget that has a size of given value and
///
/// is used to create space between widgets in a [CustomScrollView].
class SliverGap extends LeafRenderObjectWidget {
  const SliverGap(this.value, {super.key}) : assert(value > 0, 'Value of SliverGap must be greater than zero');

  /// The size of the gap
  final double value;

  @override
  RenderObject createRenderObject(BuildContext context) => _SliverGapRenderBox(value: value);

  @override
  void updateRenderObject(
    BuildContext context,
    _SliverGapRenderBox renderObject,
  ) =>
      renderObject.reEvaluate(value: value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${describeIdentity(this)} (value: $value)';
  }
}

/// A [RenderSliver] that creates a gap of given size
final class _SliverGapRenderBox extends RenderSliver {
  _SliverGapRenderBox({required this.value});

  double value;

  @override
  void performLayout() {
    final cacheExtent = calculateCacheOffset(constraints, from: 0, to: value);
    final paintExtent = calculatePaintOffset(constraints, from: 0, to: value);

    geometry = SliverGeometry(
      paintExtent: paintExtent,
      maxPaintExtent: value,
      cacheExtent: cacheExtent,
      scrollExtent: value,
    );
  }

  // ignore: use_setters_to_change_properties
  void reEvaluate({required double value}) {
    if (this.value == value) return;
    this.value = value;
    markNeedsLayout();
    markNeedsSemanticsUpdate();
  }
}
