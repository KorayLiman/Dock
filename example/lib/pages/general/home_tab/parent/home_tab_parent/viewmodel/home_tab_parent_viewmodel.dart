import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman/product/mixins/single_ticker_provider_viewmodel_mixin.dart';

final class HomeTabParentViewModel extends BaseViewModel<HomeTabParentViewModel> with SingleTickerProviderViewModelMixin {
  static HomeTabParentViewModel get get => Locator.get<HomeTabParentViewModel>();

  static HomeTabParentViewModel? get tryGet => Locator.tryGet<HomeTabParentViewModel>();
  late final BuildContext _context;
  late final TabController tabController;

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

  @override
  BuildContext get context => _context;
}
