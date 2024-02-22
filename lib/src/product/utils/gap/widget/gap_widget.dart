import 'package:dock_flutter/src/product/extensions/object_extensions/object_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// An empty widget that has a size of given value and
///
/// is used to create space between widgets in a [Column], [Row], [Flex], [ListView] or [CustomScrollView].
///
/// Similar to using [SizedBox]
class Gap extends LeafRenderObjectWidget {
  const Gap(this.value, {super.key}) : assert(value > 0, 'Value of Gap must be greater than 0');

  /// The size of the gap
  final double value;

  @override
  RenderObject createRenderObject(BuildContext context) => _GapRenderBox(value: value, axisDirection: Scrollable.maybeOf(context)?.axisDirection);

  @override
  void updateRenderObject(BuildContext context, _GapRenderBox renderObject) {
    renderObject.reEvaluate(
      value: value,
      axisDirection: Scrollable.maybeOf(context)?.axisDirection,
    );
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '${describeIdentity(this)} (value: $value)';
  }
}

/// A [RenderBox] that creates a gap of given size
final class _GapRenderBox extends RenderBox {
  _GapRenderBox({required this.value, required this.axisDirection});

  double value;
  AxisDirection? axisDirection;

  @override
  void performLayout() {
    size = constraints.constrain(_calculateSize());
  }

  /// Calculates the size of the gap
  ///
  /// If the parent is a [RenderFlex] eg. widgets like [Column], [Row], [Flex], the size is calculated based on the direction of the flex.
  ///
  /// If the parent is a [Scrollable] eg. widget like [ListView], the size is calculated based on the axis direction of the scrollable.
  Size _calculateSize() {
    if (parent.isNotNull && parent is RenderFlex) {
      final axis = (parent! as RenderFlex).direction;
      if (axis == Axis.horizontal) {
        return Size(value, 0);
      } else {
        return Size(0, value);
      }
    } else if (axisDirection.isNotNull) {
      final axis = axisDirectionToAxis(axisDirection!);
      if (axis == Axis.horizontal) {
        return Size(value, 0);
      } else {
        return Size(0, value);
      }
    } else {
      throw Exception(
        'Gap must be inserted into a Scrollable, Column, Row or Flex',
      );
    }
  }

  void reEvaluate({required double value, required AxisDirection? axisDirection}) {
    this.value = value;
    this.axisDirection = axisDirection;
  }
}
