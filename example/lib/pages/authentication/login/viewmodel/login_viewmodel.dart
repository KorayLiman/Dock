import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman_example/core/navigation/app_router/app_router.gr.dart';
import 'package:liman_example/product/utils/loader_manager/loader_manager.dart';

final class LoginViewModel extends BaseViewModel<LoginViewModel> {
  static LoginViewModel get get => Locator.get<LoginViewModel>();

  static LoginViewModel? get tryGet => Locator.tryGet<LoginViewModel>();

  void showAndHideLoader() {
    LoaderManager.show();
    1.seconds.delay(LoaderManager.hide);
  }

  Future<void> goToHomePage({required BuildContext context}) async {
    await context.pushRoute(HomeRoute());
  }
}
