import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/observer/observer_stateless_widget.dart';

typedef WidgetCallback = Widget Function();

@immutable
final class Observer extends ObserverBaseStatelessWidget {
  const Observer({required this.builder, super.key});

  final WidgetCallback builder;

  @override
  Widget build(BuildContext context) {
    return builder.call();
  }
}
