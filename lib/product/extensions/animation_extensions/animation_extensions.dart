import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

extension AnimationExtension on Widget {
  OpacityAnim fadeIn({
    Duration duration = OpacityAnim.defaultDuration,
    Duration delay = OpacityAnim.defaultDelay,
    Curve curve = OpacityAnim.defaultCurve,
    Curve? reverseCurve,
    double begin = 0,
    double end = 1,
  }) {
    return OpacityAnim(
      duration: duration,
      delay: delay,
      begin: begin,
      end: end,
      curve: curve,
      reverseCurve: reverseCurve,
      child: this,
    );
  }

  OpacityAnim fadeOut({
    Duration duration = OpacityAnim.defaultDuration,
    Duration delay = OpacityAnim.defaultDelay,
    Curve curve = OpacityAnim.defaultCurve,
    Curve? reverseCurve,
    double begin = 1,
    double end = 0,
  }) {
    return OpacityAnim(
      duration: duration,
      delay: delay,
      begin: begin,
      end: end,
      curve: curve,
      reverseCurve: reverseCurve,
      child: this,
    );
  }
}
