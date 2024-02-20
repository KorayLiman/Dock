import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/children/home_settings_child/viewmodel/home_settings_child_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeSettingsChildView extends BaseView<HomeSettingsChildViewModel> {
  HomeSettingsChildView({super.arguments}) : super(viewModel: HomeSettingsChildViewModel(), viewConfig: const ViewConfig(inject: false), key: const AutomationKey(Automation.homeTabSettingsChildView));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeSettingsChildViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => HomeSettingsChildOnSuccessWidget._(viewModel: viewModel),
    );
  }
}

class HomeSettingsChildOnSuccessWidget extends StatelessWidget {
  const HomeSettingsChildOnSuccessWidget._({required this.viewModel});

  final HomeSettingsChildViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: viewModel.navigateToMain,
          child: const Text('Navigate to main'),
        ),
      ),
    );
  }
}
