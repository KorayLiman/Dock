import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel<_TestViewModel> with SingleTickerProviderViewModelMixin {
  late BuildContext _element;
  late final AnimationController animationController;
  late final Animation<double> tweenAnimation;

  @override
  void onInit(BuildContext element) {
    _element = element;

    animationController = AnimationController(vsync: this, duration: 3.seconds);
    tweenAnimation = Tween<double>(begin: 10, end: 100).animate(animationController);

    super.onInit(element);
  }

  @override
  void onNextFrame(Duration timeStamp) {
    animationController.forward(from: 0);
    super.onNextFrame(timeStamp);
  }

  @override
  BuildContext get context => _element;
}

void main() {
  final viewModel = _TestViewModel();

  late BoxConstraints boxConstraints;

  testWidgets(
    'Single child VM mixin',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DockBuilder<_TestViewModel>(
              viewModel: viewModel,
              onSuccess: () {
                return AnimatedBuilder(
                  animation: viewModel.animationController,
                  builder: (context, child) {
                    return SizedBox(
                      height: viewModel.tweenAnimation.value,
                      width: viewModel.tweenAnimation.value,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          boxConstraints = constraints;
                          return const SizedBox.shrink();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(boxConstraints.maxHeight, 100.0);
      expect(boxConstraints.maxWidth, 100.0);
    },
  );
}
