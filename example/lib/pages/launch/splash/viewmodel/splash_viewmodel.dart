import 'package:dock/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock/core/locator/locator.dart';
import 'package:dock_example/core/navigation/app_router/app_router.dart';
import 'package:dock_example/core/navigation/app_router/app_router.gr.dart';

final class SplashViewModel extends BaseViewModel<SplashViewModel> {
  static SplashViewModel get find => Locator.find<SplashViewModel>();

  static SplashViewModel? get tryFind => Locator.tryFind<SplashViewModel>();

  Future<void> goToNextPage() async {
    await AppRouter.find.replace(LoginRoute());
  }
}
