import 'package:flutter/material.dart';

abstract class AppKeys {
  static final stateKeys = StateKeys._();
}

final class StateKeys {
  StateKeys._();
  final rootScaffoldMessengerStateKey = GlobalKey<ScaffoldMessengerState>();
}
