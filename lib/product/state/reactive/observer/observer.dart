import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/observer/observer_base_stateless_widget.dart';

typedef WidgetCallback = Widget Function();

@immutable

/// A reactive [StatelessWidget] receives updates when containing
///
/// observables' values change
final class Observer extends ObserverBaseStatelessWidget {
  const Observer({required this.builder, super.key});

  final WidgetCallback builder;

  @override
  Widget build(BuildContext context) {
    return builder.call();
  }
}
