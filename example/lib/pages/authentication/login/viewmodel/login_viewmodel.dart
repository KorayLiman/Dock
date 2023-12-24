import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class LoginViewModel extends BaseViewModel with ServiceMixin<LoginService> {
  Future<void> login() async {
    final result = await service.login();
  }

  void showAndHideLoader() {
    rootPopupManager.showLoader();
    2.seconds.delay(rootPopupManager.hideLoader);
  }

  Future<void> goToHomePage() async {
    await rootRouter.push(HomeTabParentRoute());
  }

  void showToast() {
    rootOverlayManager.showToast(
      message: 'İşlem başarılı bir şekilde gerçekleşti 🥂!',
      messageStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      backgroundColor: Colors.green,
      shadowColor: Colors.green.shade500,
      leading: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
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
