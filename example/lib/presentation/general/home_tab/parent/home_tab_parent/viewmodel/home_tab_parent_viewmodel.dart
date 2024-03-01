import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

final class HomeTabParentViewModel extends BaseViewModel with DockSingleTickerProviderMixin {
  late final TabController tabController;

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    setPageState(PageState.loading);
    super.onInit();
  }

  @override
  void onPostFrame(Duration timeStamp) {
    1.seconds.delay(() {
      setPageState(PageState.success);
    });
    super.onPostFrame(timeStamp);
  }

  @override
  void onDispose() {
    tabController.dispose();

    super.onDispose();
  }
}
