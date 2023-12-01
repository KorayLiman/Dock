import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

final class HomeTabParentViewModel extends BaseViewModel<HomeTabParentViewModel> with DockSingleTickerProviderMixin {
  static HomeTabParentViewModel get find => Locator.find<HomeTabParentViewModel>();

  static HomeTabParentViewModel? get tryFind => Locator.tryFind<HomeTabParentViewModel>();
  late final BuildContext _context;
  late final TabController tabController;

  @override
  BuildContext get context => _context;

  @override
  void onInit(BuildContext element) {
    _context = element;
    tabController = TabController(length: 4, vsync: this);
    setPageState(PageState.loading);
    super.onInit(element);
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
