import 'package:dock_flutter/dock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BaseAnimatedWidget extends StatefulWidget {
  const BaseAnimatedWidget({required this.child, required this.builder, required this.duration, required this.begin, required this.end, required this.delay, required this.curve, this.reverseCurve, super.key});

  final Duration duration;
  final Duration delay;
  final double begin;
  final double end;
  final ValueWidgetBuilder<double> builder;
  final Widget child;
  final Curve curve;
  final Curve? reverseCurve;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('duration', duration))
      ..add(DiagnosticsProperty('delay', delay))
      ..add(DiagnosticsProperty('begin', begin))
      ..add(DiagnosticsProperty('end', end))
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('child', child))
      ..add(DiagnosticsProperty('curve', curve))
      ..add(DiagnosticsProperty('reverseCurve', reverseCurve));

    super.debugFillProperties(properties);
  }

  @override
  _BaseAnimatedWidgetState createState() => _BaseAnimatedWidgetState();
}

class _BaseAnimatedWidgetState extends State<BaseAnimatedWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final CurvedAnimation _animation;

  bool _animStarted = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: Tween<double>(begin: widget.begin, end: widget.end).animate(_animationController), curve: widget.curve, reverseCurve: widget.reverseCurve);

    widget.delay.delay(() {
      if (mounted) {
        _animStarted = true;
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return widget.builder(context, _animStarted ? _animation.value : 1, child);
      },
      child: widget.child,
    );
  }
}
