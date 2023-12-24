import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/navigation.dart';
import 'package:dock_flutter_example/product/constants/constants.dart';
import 'package:dock_flutter_example/product/keys/keys.dart';
import 'package:flutter/material.dart';

part 'app/app.dart';
part 'app/configuration.dart';
part 'app/mixin.dart';

void main() {
  runZonedGuarded(
    () {
      preConfigure();
      runApp(const DockApp());
    },
    (error, stack) {
      // Report to Crashlytics
    },
  );
}
