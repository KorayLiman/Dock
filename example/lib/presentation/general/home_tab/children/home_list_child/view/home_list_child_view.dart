import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/children/home_list_child/viewmodel/home_list_child_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class HomeListChildView extends BaseView<HomeListChildViewModel> {
  const HomeListChildView({required super.viewModelCallback, super.key});

  @override
  Widget onSuccess(BuildContext context, HomeListChildViewModel viewModel) {
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
