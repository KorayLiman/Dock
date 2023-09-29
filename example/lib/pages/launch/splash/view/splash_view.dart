import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/dock_builder/dock_builder.dart';
import 'package:liman_example/pages/launch/splash/viewmodel/splash_viewmodel.dart';
import 'package:liman_example/product/components/appbars/appbars.dart';
import 'package:liman_example/product/enums/route_paths.dart';
import 'package:liman_example/product/extensions/route_paths_extensions/route_paths_extension.dart';

@RoutePage()
final class SplashView extends BaseView<SplashViewModel> {
  SplashView({super.arguments}) : super(viewModel: SplashViewModel(), key: ValueKey<String>(RoutePaths.splash.rawValue));

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Splash',
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            await viewModel.goToNextPage(context: context);
          },
          label: const Text('Go to Login Page'),
          icon: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
