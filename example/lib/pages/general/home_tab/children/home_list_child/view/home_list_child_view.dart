import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/pages/general/home_tab/children/home_list_child/viewmodel/home_list_child_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeListChildView extends BaseView<HomeListChildViewModel> {
  HomeListChildView({super.arguments, super.key}) : super(viewModel: HomeListChildViewModel(), viewConfig: const ViewConfig(inject: false));

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder<HomeListChildViewModel>(
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
