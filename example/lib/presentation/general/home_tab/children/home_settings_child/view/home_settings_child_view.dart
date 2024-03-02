import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/children/home_settings_child/viewmodel/home_settings_child_viewmodel.dart';
import 'package:flutter/material.dart';

final class HomeSettingsChildView extends BaseView<HomeSettingsChildViewModel> {
  HomeSettingsChildView({super.key})
      : super(
          viewModel: HomeSettingsChildViewModel(),
        );

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
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
          );
        },
        separatorBuilder: (context, index) {
          return const Gap(20);
        },
        itemCount: 2,
      ),
    );
  }
}
