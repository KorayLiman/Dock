import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/children/home_list_child/viewmodel/home_list_child_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class HomeListChildView extends BaseView<HomeListChildViewModel> {
  HomeListChildView({super.key})
      : super(
          viewModel: HomeListChildViewModel(),
        );

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeListChildViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => HomeListChildOnSuccessWidget._(viewModel: viewModel),
    );
  }
}

class HomeListChildOnSuccessWidget extends StatelessWidget {
  const HomeListChildOnSuccessWidget._({required this.viewModel});

  final HomeListChildViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(
        title: 'Home List Child',
      ),
      body: DockRefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
          itemCount: 99,
        ),
      ),
    );
  }
}
