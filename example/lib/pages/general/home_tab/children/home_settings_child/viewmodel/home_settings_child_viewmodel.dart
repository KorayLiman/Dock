import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/mixin/home_tabs_router_mixin.dart';

final class HomeSettingsChildViewModel extends BaseViewModel with HomeTabsRouterMixin {
  void navigateToMain() {
    homeTabsRouter.setActiveIndex(0);
  }
}
