import 'package:dock/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock/core/locator/locator.dart';
import 'package:dock/product/extensions/extensions.dart';
import 'package:dock_example/core/navigation/app_router/app_router.dart';
import 'package:dock_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_example/product/utils/loader_manager/loader_manager.dart';

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
