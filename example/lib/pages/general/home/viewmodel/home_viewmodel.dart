import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman/product/mixins/single_ticker_provider_viewmodel_mixin.dart';

final class HomeViewModel extends BaseViewModel with SingleTickerProviderViewModelMixin {
  static HomeViewModel get get => Locator.get<HomeViewModel>();
  static HomeViewModel? get tryGet => Locator.tryGet<HomeViewModel>();
  late final BuildContext _stateContext;
  late final TabController tabController;

  @override
  void onInit(BuildContext stateContext) {
    _stateContext = stateContext;
    tabController = TabController(length: 4, vsync: this);

    super.onInit(stateContext);
  }

  @override
  void onDispose() {
    tabController.dispose();

    super.onDispose();
  }

  @override
  BuildContext get stateContext => _stateContext;
}
