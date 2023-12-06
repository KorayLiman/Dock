import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class SplashViewModel extends BaseViewModel<SplashViewModel> with ServiceMixin<SplashService> {
  @override
  void onInit(BuildContext element) {
    _registerDependencies();
    super.onInit(element);
  }

  void _registerDependencies() {
    Locator
      ..registerLazy<SplashService>(() => const SplashService(), keepAlive: true)
      ..registerLazy<LoginService>(() => const LoginService(), keepAlive: true);
  }

  Future<void> goToNextPage() async {
    await rootRouter.replace(LoginRoute());
  }
}
