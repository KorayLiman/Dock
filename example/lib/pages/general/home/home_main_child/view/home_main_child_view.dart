import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/dock_builder/dock_builder.dart';
import 'package:liman/product/state/primitive/docker/docker.dart';
import 'package:liman/product/state/reactive/observer/observer.dart';
import 'package:liman_example/pages/general/home/home_main_child/viewmodel/home_main_child_viewmodel.dart';

@RoutePage()
final class HomeMainChildView extends BaseView<HomeMainChildViewModel> {
  HomeMainChildView({super.arguments, super.key}) : super(viewModel: HomeMainChildViewModel(), inject: false);

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Observer(
              builder: () => Text('Count: ${viewModel.count.value}'),
            ),
            Observer(
              builder: () => Text('Weight: ${viewModel.weight.value}'),
            ),
            Docker(
              id: '0',
              viewModel: viewModel,
              builder: (viewModel) => Text(viewModel.age.toString()),
            ),
          ],
        ),
      ),
      floatingActionButton: _homeMainFloatingActionButton(context: context, viewModel: viewModel),
    );
  }

  Widget _homeMainFloatingActionButton({required BuildContext context, required HomeMainChildViewModel viewModel}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          onPressed: viewModel.incrementCounter,
          label: const Text('Increment counter'),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton.extended(
          onPressed: viewModel.incrementWeight,
          label: const Text('Increment weight'),
          icon: const Icon(Icons.add),
        ),
        FloatingActionButton.extended(
          onPressed: viewModel.incrementAge,
          label: const Text('Increment age'),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
