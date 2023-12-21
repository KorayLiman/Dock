import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/product/keys/keys.dart';

extension HomeTabsRouterExtension on BaseViewModel {
  TabsRouter get homeTabsRouter {
    final controller = AppKeys.stateKeys.homeTabRouterStateKey.currentState?.controller;
    assert(controller.isNotNull, '''
    HomeTabsRouterExtension: Tried to get homeTabsRouter but it's state or router was null''');
    return controller!;
  }
}
