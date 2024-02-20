import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/mixin/home_tabs_router_mixin.dart';

final class HomeListChildViewModel extends BaseViewModel with HomeTabsRouterMixin {
  @override
  void onInit() {
    //  5.seconds.delay(() {
    //   stateBuilderContext.rebuildWidget();
    // });
    super.onInit();
  }

  void navigateToSettings() {
    homeTabsRouter.setActiveIndex(2);
  }

  Future<void> onRefresh() async {
    await 2.seconds.delay();
  }
}
