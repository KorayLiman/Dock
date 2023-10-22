import 'package:dock_flutter/product/state/reactive/observer/observer_stateless_element.dart';
import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

/// A reactive [StatelessWidget] receives update when containing
///
/// Observable's value changes
final class Observer extends StatelessWidget {
  const Observer({required this.builder, super.key});

  final WidgetCallbackViaContext builder;

  @override
  StatelessElement createElement() => ObserverStatelessElement(this);

  @override
  Widget build(BuildContext context) {
    return builder.call(context);
  }
}
