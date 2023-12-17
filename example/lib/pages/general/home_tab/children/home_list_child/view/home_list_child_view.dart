import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/children/home_list_child/viewmodel/home_list_child_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeListChildView extends BaseView<HomeListChildViewModel> {
  HomeListChildView({super.arguments}) : super(viewModel: HomeListChildViewModel(), viewConfig: const ViewConfig(inject: false), key: const AutomationKey(Automation.homeTabListChildView));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeListChildViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => HomeListChildOnSuccessWidget(viewModel: viewModel),
    );
  }
}

class HomeListChildOnSuccessWidget extends StatelessWidget {
  @visibleForTesting
  const HomeListChildOnSuccessWidget({required this.viewModel, super.key});

  final HomeListChildViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => viewModel.navigateToSettings(context: context),
          child: const Text('Navigate to settings'),
        ),
      ),
    );
  }
}
