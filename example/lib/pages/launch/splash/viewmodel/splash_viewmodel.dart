import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';

final class SplashViewModel extends BaseViewModel<SplashViewModel> {
  static SplashViewModel get find => Locator.find<SplashViewModel>();

  static SplashViewModel? get tryFind => Locator.tryFind<SplashViewModel>();

  Future<void> goToNextPage() async {
    await AppRouter.find.replace(LoginRoute());
  }
}
