import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/extensions/home_tabs_router_extension.dart';

final class HomeSettingsChildViewModel extends BaseViewModel<HomeSettingsChildViewModel> {
  void navigateToMain() {
    homeTabsRouter.setActiveIndex(0);
  }
}
