import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/observer/observer_element.dart';

abstract base class ObserverStatelessWidget extends StatelessWidget {
  const ObserverStatelessWidget({super.key});
  @override
  StatelessElement createElement() => ObserverElement(this);
}
