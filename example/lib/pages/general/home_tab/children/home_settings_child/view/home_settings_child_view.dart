import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/children/home_settings_child/viewmodel/home_settings_child_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeSettingsChildView extends BaseView<HomeSettingsChildViewModel> {
  HomeSettingsChildView({super.arguments, super.key}) : super(viewModel: HomeSettingsChildViewModel(), viewConfig: const ViewConfig(inject: false));

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder<HomeSettingsChildViewModel>(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('Navigate to main'),
        ),
      ),
    );
  }
}
