import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/main.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class LoginViewModel extends BaseViewModel {
  Future<void> login() async {
    await 2.seconds.delay();
  }

  void showAndHideLoader() {
    rootPopupManager.showLoader();
    2.seconds.delay(rootPopupManager.hideLoader);
  }

  Future<void> goToHomePage() async {
    await rootRouter.push(RouteNames.homeTab.name);
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
}
