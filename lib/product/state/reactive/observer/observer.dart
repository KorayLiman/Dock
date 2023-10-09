import 'package:flutter/material.dart';
import 'package:dock/product/state/reactive/observer/observer_stateless_element.dart';

typedef WidgetCallback = Widget Function(BuildContext context);

/// A reactive [StatelessWidget] receives updates when containing
///
/// observables' values change
final class Observer extends StatelessWidget {
  const Observer({required this.builder, super.key});

  final WidgetCallback builder;

  @override
  StatelessElement createElement() => ObserverStatelessElement(this);

  @override
  Widget build(BuildContext context) {
    return builder.call(context);
  }
}
