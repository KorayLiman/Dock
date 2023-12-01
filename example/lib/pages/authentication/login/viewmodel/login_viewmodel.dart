import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/extensions/base_viewmodel_extension/base_viewmodel_extension.dart';
import 'package:flutter/material.dart';

final class LoginViewModel extends BaseViewModel<LoginViewModel> {
  static LoginViewModel get find => Locator.find<LoginViewModel>();

  static LoginViewModel? get tryFind => Locator.tryFind<LoginViewModel>();

  void showAndHideLoader() {
    rootLoaderManager.show();
    2.seconds.delay(rootLoaderManager.hide);
  }

  Future<void> goToHomePage() async {
    await router.push(HomeTabParentRoute());
  }

  void showDefaultToast() {
    rootOverlayManager.showToast('Default toast, ' * 10);
  }

  void showCustomOverlay() {
    rootOverlayManager.showOverlay(
      positionedBuilder: (context) => const Positioned(
        height: 120,
        bottom: 40,
        left: 40,
        right: 40,
        child: ColoredBox(
          color: Colors.red,
          child: Center(
            child: Text(
              'Custom Overlay',
              style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
