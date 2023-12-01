import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/extensions/base_viewmodel_extension/base_viewmodel_extension.dart';

final class SplashViewModel extends BaseViewModel<SplashViewModel> {
  static SplashViewModel get find => Locator.find<SplashViewModel>();

  static SplashViewModel? get tryFind => Locator.tryFind<SplashViewModel>();

  Future<void> goToNextPage() async {
    await router.replace(LoginRoute());
  }
}
