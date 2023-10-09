import 'package:auto_route/auto_route.dart';
import 'package:dock/core/base/view/base_view.dart';
import 'package:dock/core/widget/dock_builder/dock_builder.dart';
import 'package:dock_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_example/pages/general/home_tab/children/home_list_child/viewmodel/home_list_child_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeListChildView extends BaseView<HomeListChildViewModel> {
  HomeListChildView({super.arguments, super.key}) : super(viewModel: HomeListChildViewModel(), inject: false);

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.navigateTo(HomeSettingsChildRoute());
          },
          child: const Text('Navigate to settings'),
        ),
      ),
    );
  }
}
