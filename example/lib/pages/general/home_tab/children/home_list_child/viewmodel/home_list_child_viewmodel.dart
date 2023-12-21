import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/extensions/home_tabs_router_extension.dart';

final class HomeListChildViewModel extends BaseViewModel<HomeListChildViewModel> {
  void navigateToSettings() {
    homeTabsRouter.setActiveIndex(2);
  }

  @override
  void onInit() {
    5.seconds.delay(() {
      stateBuilderContext.rebuildWidget();
    });
    super.onInit();
  }
}
