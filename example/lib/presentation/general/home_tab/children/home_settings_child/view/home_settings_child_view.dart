import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/children/home_settings_child/viewmodel/home_settings_child_viewmodel.dart';
import 'package:flutter/material.dart';

final class HomeSettingsChildView extends BaseView<HomeSettingsChildViewModel> {
  const HomeSettingsChildView({required super.viewModelCallback, super.key});

  @override
  Widget onSuccess(BuildContext context, HomeSettingsChildViewModel viewModel) {
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
