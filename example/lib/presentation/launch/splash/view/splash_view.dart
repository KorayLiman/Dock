import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/launch/splash/viewmodel/splash_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class SplashView extends BaseView<SplashViewModel> {
  SplashView({super.key}) : super(viewModel: Locator.registerAsNew(SplashViewModel()));

  @override
  Widget onSuccess(BuildContext context) {
    throw UnimplementedError();
  }
}

class SplashViewOnSuccessWidget extends DockStatelessWidget<SplashViewModel> {
  const SplashViewOnSuccessWidget._();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Splash',
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: viewModel.goToNextPage,
          label: const Text('Go to Login Page'),
          icon: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
