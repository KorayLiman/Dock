import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/general/home_tab/children/home_main_child/viewmodel/home_main_child_viewmodel.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeMainChildView extends BaseView<HomeMainChildViewModel> {
  HomeMainChildView({super.arguments, super.key}) : super(viewModel: HomeMainChildViewModel(), viewConfig: const ViewConfig(inject: false));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeMainChildViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => _onSuccess(context: context),
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
            const Blank(12),
            Docker(
              id: '0',
              viewModel: viewModel,
              builder: (context, viewModel) => Text('(Docker) Age: ${viewModel.age}'),
            ),
            const SizedBox(
              height: 100,
              child: CustomScrollView(
                slivers: [
                  SliverBlank(40),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Center(child: Text('Sliver elem 1')),
                        Blank(9),
                        Center(child: Text('Sliver elem 2')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Blurred(
                borderRadius: BorderRadius.circular(12),
                overlay: const Icon(Icons.blur_circular),
                blur: 20,
                child: Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey.shade400,
                ),
              ),
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
