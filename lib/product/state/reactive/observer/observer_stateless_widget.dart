import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/observer/observer_element.dart';

abstract base class ObserverBaseStatelessWidget extends StatelessWidget {
  const ObserverBaseStatelessWidget({super.key});
  @override
  StatelessElement createElement() => ObserverElement(this);
}
