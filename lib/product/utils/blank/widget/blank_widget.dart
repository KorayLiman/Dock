import 'package:dock_flutter/product/extensions/object_extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Blank extends StatelessWidget {
  const Blank(this.value, {super.key}) : assert(value > 0, 'Value of Blank must be greater than zero');

  final double value;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DoubleProperty('value', value));
    super.debugFillProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    final scrollableAxisDirection = Scrollable.maybeOf(context)?.axisDirection;

    return _BlankRenderObjectWidget(
      value: value,
      axisDirection: scrollableAxisDirection,
    );
  }
}

final class _BlankRenderObjectWidget extends LeafRenderObjectWidget {
  const _BlankRenderObjectWidget({required this.value, required this.axisDirection});

  final AxisDirection? axisDirection;
  final double value;

  @override
  RenderObject createRenderObject(BuildContext context) => _BlankRenderBox(value: value, axisDirection: axisDirection);

  @override
  void updateRenderObject(BuildContext context, _BlankRenderBox renderObject) {
    if (value != renderObject.value) {
      renderObject._reSize(value: value);
    }
  }
}

final class _BlankRenderBox extends RenderBox {
  _BlankRenderBox({required this.value, required this.axisDirection});

  double value;
  final AxisDirection? axisDirection;

  Size get _directionalSize {
    if (axisDirection.isNotNull) {
      final axis = axisDirectionToAxis(axisDirection!);
      if (axis == Axis.horizontal) {
        return Size(value, 0);
      } else {
        return Size(0, value);
      }
    } else {
      assert(parent is RenderFlex, 'Blank must be inserted into a Scrollable, Column, Row or Flex');
      final axis = (parent! as RenderFlex).direction;
      if (axis == Axis.horizontal) {
        return Size(value, 0);
      } else {
        return Size(0, value);
      }
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return value;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return value;
  }

  void _reSize({required double value}) {
    this.value = value;
    markNeedsLayout();
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return constraints.constrain(_directionalSize);
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }
}
