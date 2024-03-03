import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel with DockSingleTickerProviderMixin {
  late final AnimationController animationController;
  late final Animation<double> tweenAnimation;
  late BoxConstraints boxConstraints;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: 3.seconds);
    tweenAnimation = Tween<double>(begin: 10, end: 100).animate(animationController);
    super.onInit();
  }

  @override
  void onNextFrame(Duration timeStamp) {
    animationController.forward(from: 0);
    super.onNextFrame(timeStamp);
  }
}

final class _TestView extends BaseView<_TestViewModel> {
  _TestView() : super(viewModel: Locator.register(_TestViewModel()));

  @override
  Widget onSuccess(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: viewModel.animationController,
        builder: (context, child) {
          return SizedBox(
            height: viewModel.tweenAnimation.value,
            width: viewModel.tweenAnimation.value,
            child: LayoutBuilder(
              builder: (context, constraints) {
                viewModel.boxConstraints = constraints;
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

void main() {
  testWidgets(
    'Single child VM mixin',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: _TestView(),
        ),
      );
      await tester.pumpAndSettle();
      final viewModel = Locator.find<_TestViewModel>();
      expect(viewModel.boxConstraints.maxHeight, 100.0);
      expect(viewModel.boxConstraints.maxWidth, 100.0);
    },
  );
}
