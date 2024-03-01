import 'package:dock_flutter/dock.dart';
import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

final class HomeListChildViewModel extends BaseViewModel {
  @override
  void onInit() {
    //  5.seconds.delay(() {
    //   stateBuilderContext.rebuildWidget();
    // });
    super.onInit();
  }

  void navigateToSettings(BuildContext context) {
    TabsBuilder.of(context).setActiveIndex(2);
  }

  Future<void> onRefresh() async {
    await 2.seconds.delay();
  }
}
