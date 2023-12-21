import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

abstract class AppKeys {
  static final stateKeys = _StateKeys();
}

final class _StateKeys {
  final homeTabRouterStateKey = GlobalKey<AutoTabsRouterState>();
  final rootScaffoldMessengerStateKey = GlobalKey<ScaffoldMessengerState>();
}
