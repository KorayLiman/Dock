import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/core/base/view/base_view.dart';
import 'package:dock_flutter/core/widget/state_builder/state_builder.dart';
import 'package:dock_flutter_example/pages/launch/splash/viewmodel/splash_viewmodel.dart';
import 'package:dock_flutter_example/product/components/appbars/appbars.dart';
import 'package:dock_flutter_example/product/enums/route_paths.dart';
import 'package:dock_flutter_example/product/extensions/route_paths_extensions/route_paths_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class SplashView extends BaseView<SplashViewModel> {
  SplashView({super.arguments}) : super(viewModel: SplashViewModel(), key: ValueKey<String>(RoutePaths.splash.rawValue));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<SplashViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
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
