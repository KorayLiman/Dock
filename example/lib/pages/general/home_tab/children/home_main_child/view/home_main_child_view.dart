import 'package:auto_route/auto_route.dart';
import 'package:dock/core/base/view/base_view.dart';
import 'package:dock/core/widget/dock_builder/dock_builder.dart';
import 'package:dock/product/state/primitive/docker/docker.dart';
import 'package:dock/product/state/reactive/observer/observer.dart';
import 'package:dock_example/pages/general/home_tab/children/home_main_child/viewmodel/home_main_child_viewmodel.dart';
import 'package:flutter/material.dart';

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
              builder: (context) => Text('(Observer) Count: ${viewModel.count.value}'),
            ),
            Observer(
              builder: (context) => Text('(Observer) Weight: ${viewModel.weight.value}'),
            ),
            Docker(
              id: '0',
              viewModel: viewModel,
              builder: (context, viewModel) => Text('(Docker) Age: ${viewModel.age}'),
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
          heroTag: null,
          onPressed: viewModel.incrementCounter,
          label: const Text('Increment count'),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: viewModel.incrementWeight,
          label: const Text('Increment weight'),
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: viewModel.incrementAge,
          label: const Text('Increment age'),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
