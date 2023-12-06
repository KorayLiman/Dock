import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';

final class HomeSettingsChildViewModel extends BaseViewModel<HomeSettingsChildViewModel> {
  Future<void> navigateToMain({required BuildContext context}) async {
    await AutoTabsRouter.of(context).navigate(HomeMainChildRoute());
  }
}
