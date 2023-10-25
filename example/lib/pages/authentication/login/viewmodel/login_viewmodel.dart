import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/utils/loader_manager/loader_manager.dart';
import 'package:dock_flutter_example/product/utils/overlay_manager/overlay_manager.dart';
import 'package:flutter/material.dart';

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

  void showDefaultToast() {
    OverlayManager().showToast("Default toast, " * 10);
  }

  void showCustomOverlay() {
    OverlayManager().showCustomOverlay(
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
