import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/utils/loader_manager/loader_manager.dart';

final class LoginViewModel extends BaseViewModel<LoginViewModel> {
  static LoginViewModel get find => Locator.find<LoginViewModel>();

  static LoginViewModel? get tryFind => Locator.tryFind<LoginViewModel>();

  void showAndHideLoader() {
    LoaderManager.show();
    1.seconds.delay(LoaderManager.hide);
  }

  Future<void> goToHomePage() async {
    await AppRouter.find.push(HomeTabParentRoute());
  }
}
