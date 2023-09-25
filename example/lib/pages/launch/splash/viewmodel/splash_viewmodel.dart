import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman_example/core/navigation/app_router/app_router.gr.dart';

final class SplashViewModel extends BaseViewModel<SplashViewModel> {
  static SplashViewModel get get => Locator.get<SplashViewModel>();
  static SplashViewModel? get tryGet => Locator.tryGet<SplashViewModel>();

  Future<void> goToNextPage({required BuildContext context}) async {
    await context.replaceRoute(LoginRoute());
  }
}
