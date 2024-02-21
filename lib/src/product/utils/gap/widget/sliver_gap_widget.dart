import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverGap extends LeafRenderObjectWidget {
  const SliverGap(this.value, {super.key})
      : assert(value > 0, 'Value of SliverGap must be greater than zero');

  final double value;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _SliverGapRenderBox(value: value);

  @override
  void updateRenderObject(
          BuildContext context, _SliverGapRenderBox renderObject) =>
      renderObject.reEvaluate(value: value);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${describeIdentity(this)} (value: $value)';
  }
}

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
    this.value = value;
  }
}
