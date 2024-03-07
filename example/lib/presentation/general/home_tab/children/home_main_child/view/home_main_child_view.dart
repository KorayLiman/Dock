import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/children/home_main_child/viewmodel/home_main_child_viewmodel.dart';
import 'package:flutter/material.dart';

final class HomeMainChildView extends BaseView<HomeMainChildViewModel> {
  const HomeMainChildView({required super.viewModelCallback, super.key});

  @override
  Widget onSuccess(BuildContext context, HomeMainChildViewModel viewModel) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.blue,
              height: 40,
              width: 40,
            ).fadeIn(curve: Curves.bounceIn).fadeOut(delay: 1.seconds),
            Observer(
              builder: (context) => Text('(Observer) Count: ${viewModel.count.value}'),
            ),
            Observer(
              builder: (context) => Text('(Observer) Weight: ${viewModel.weight.value}'),
            ),
            const Gap(50),
            Docker(
              id: '0',
              viewModel: viewModel,
              builder: (context, viewModel) => Text('(Docker) Age: ${viewModel.age}'),
            ),
            const SizedBox(
              height: 100,
              child: CustomScrollView(
                slivers: [
                  SliverGap(40),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Center(child: Text('Sliver elem 1')),
                        Gap(8),
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
      floatingActionButton: HomeMainFloatingActionButton._(viewModel: viewModel),
    );
  }
}

class HomeMainFloatingActionButton extends StatelessWidget {
  const HomeMainFloatingActionButton._({required this.viewModel});

  final HomeMainChildViewModel viewModel;

  @override
  Widget build(BuildContext context) {
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
        const Gap(16),
        FloatingActionButton.extended(
          heroTag: null,
          onPressed: viewModel.incrementWeight,
          label: const Text('Increment weight'),
          icon: const Icon(Icons.add),
        ),
        const Gap(16),
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
