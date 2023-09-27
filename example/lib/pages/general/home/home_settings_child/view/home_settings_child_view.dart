import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/liman_manager/liman_manager.dart';
import 'package:liman_example/core/navigation/app_router/app_router.gr.dart';
import 'package:liman_example/pages/general/home/home_settings_child/viewmodel/home_settings_child_viewmodel.dart';

@RoutePage()
final class HomeSettingsChildView extends BaseView<HomeSettingsChildViewModel> {
  HomeSettingsChildView({super.arguments, super.key}) : super(viewModel: HomeSettingsChildViewModel(), inject: false);

  @override
  Widget build(BuildContext context) {
    return LimanManager(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.navigateTo(HomeMainChildRoute());
          },
          child: const Text('Navigate to main'),
        ),
      ),
    );
  }
}
