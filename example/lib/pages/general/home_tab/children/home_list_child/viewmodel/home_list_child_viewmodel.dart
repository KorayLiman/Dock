import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';

final class HomeListChildViewModel extends BaseViewModel<HomeListChildViewModel> {
  Future<void> navigateToSettings({required BuildContext context}) async {
    await AutoTabsRouter.of(context).navigate(HomeSettingsChildRoute());
  }
}
