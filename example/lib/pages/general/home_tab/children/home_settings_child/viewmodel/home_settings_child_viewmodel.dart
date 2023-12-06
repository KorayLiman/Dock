import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

final class HomeSettingsChildViewModel extends BaseViewModel<HomeSettingsChildViewModel> {
  void navigateToMain({required BuildContext context}) {
    AutoTabsRouter.of(context).setActiveIndex(0);
  }
}
