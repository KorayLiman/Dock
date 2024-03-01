import 'dart:async';

import 'package:dock_flutter_example/presentation/presentation.dart';
import 'package:dock_flutter_example/product/constants/constants.dart';
import 'package:dock_flutter_example/product/keys/keys.dart';
import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

import 'product/enums/enums.dart';

part 'app/app.dart';
part 'app/configuration.dart';
part 'app/mixin.dart';
part 'app/routes.dart';

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
