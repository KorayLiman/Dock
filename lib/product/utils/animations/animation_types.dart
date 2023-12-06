import 'package:dock_flutter/product/utils/animations/animation_base.dart';
import 'package:flutter/material.dart';

final class OpacityAnim extends BaseAnimatedWidget {
  OpacityAnim({
    required super.child,
    required super.begin,
    required super.end,
    required super.duration,
    required super.delay,
    required super.curve,
    super.key,
    super.reverseCurve,
  }) : super(
          builder: (context, value, child) => Opacity(
            key: ValueKey<double>(value),
            opacity: value,
            child: child,
          ),
        );
  static const defaultDuration = Duration(seconds: 1);
  static const defaultDelay = Duration.zero;
  static const defaultCurve = Curves.linear;
}
