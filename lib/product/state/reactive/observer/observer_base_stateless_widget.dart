import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/observer/observer_stateless_element.dart';

/// A base [StatelessWidget] overrides [createElement] method of Observer widget
abstract base class ObserverBaseStatelessWidget extends StatelessWidget {
  const ObserverBaseStatelessWidget({super.key});
  @override
  StatelessElement createElement() => ObserverStatelessElement(this);
}
