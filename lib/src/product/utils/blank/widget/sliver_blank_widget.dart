import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

@Deprecated('This is deprecated')
class SliverBlank extends LeafRenderObjectWidget {
  @Deprecated('This is deprecated')
  const SliverBlank(this.value, {super.key}) : assert(value > 0, 'Value of Blank must be greater than zero');

  final double value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DoubleProperty('value', value));
    super.debugFillProperties(properties);
  }

  @override
  RenderObject createRenderObject(BuildContext context) => _SliverBlankRenderBox(value: value);

  @override
  void updateRenderObject(BuildContext context, _SliverBlankRenderBox renderObject) {
    if (value != renderObject.value) {
      renderObject._reSize(value: value);
    }
  }
}

final class _SliverBlankRenderBox extends RenderSliver {
  _SliverBlankRenderBox({required this.value});

  double value;

  void _reSize({required double value}) {
    this.value = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final cacheExtent = calculateCacheOffset(constraints, from: 0, to: value);
    final paintExtent = calculatePaintOffset(constraints, from: 0, to: value);
    geometry = SliverGeometry(
      cacheExtent: cacheExtent,
      scrollExtent: value,
      maxPaintExtent: value,
      paintExtent: paintExtent,
    );
  }
}
