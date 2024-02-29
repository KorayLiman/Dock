import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/launch/splash/viewmodel/splash_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class SplashView extends BaseView<SplashViewModel> {
  SplashView() : super(viewModel: Locator.register(SplashViewModel()), key: const AutomationKey(Automation.splashView));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<SplashViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => const SplashViewOnSuccessWidget._(),
    );
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
