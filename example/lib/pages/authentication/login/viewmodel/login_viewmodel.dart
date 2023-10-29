import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter/product/utils/overlay_manager/overlay_manager.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:flutter/material.dart';

final class LoginViewModel extends BaseViewModel<LoginViewModel> {
  static LoginViewModel get find => Locator.find<LoginViewModel>();

  static LoginViewModel? get tryFind => Locator.tryFind<LoginViewModel>();
  LoaderManager _loaderManager = LoaderManager(AppRouter.find.navigatorKey);
  OverlayManager _overlayManager = OverlayManager(AppRouter.find.navigatorKey);

  void showAndHideLoader() {
    _loaderManager.show();
    2.seconds.delay(_loaderManager.hide);
  }

  Future<void> goToHomePage() async {
    await AppRouter.find.push(HomeTabParentRoute());
  }

  void showDefaultToast() {
    _overlayManager.showToast("Default toast, " * 10, toastPosition: ToastPosition.bottom);
  }

  void showCustomOverlay() {
    _overlayManager.showOverlay(
      positionedBuilder: (context) => Positioned(
        height: 120,
        bottom: 40,
        left: 40,
        right: 40,
        child: Container(
          color: Colors.red,
          child: Center(
            child: Text(
              "Custom Overlay",
              style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
