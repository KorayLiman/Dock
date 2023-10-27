import 'dart:math';

import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel<_TestViewModel> with DockTickerProviderMixin {
  late BuildContext _element;
  late final AnimationController animationController;
  late final AnimationController rotationAnimationController;

  late final Animation<double> tweenAnimation;
  late final Animation<double> tweenRotationAnimation;

  @override
  void onInit(BuildContext element) {
    _element = element;

    animationController = AnimationController(vsync: this, duration: 3.seconds);
    tweenAnimation = Tween<double>(begin: 10, end: 100).animate(animationController);
    rotationAnimationController = AnimationController(vsync: this, duration: 3.seconds);
    tweenRotationAnimation = Tween<double>(begin: 0, end: pi * 1.5).animate(rotationAnimationController);

    super.onInit(element);
  }

  @override
  void onNextFrame(Duration timeStamp) {
    animationController.forward(from: 0);
    rotationAnimationController.forward(from: 0);
    super.onNextFrame(timeStamp);
  }

  @override
  BuildContext get context => _element;
}

void main() {
  final viewModel = _TestViewModel();

  late BoxConstraints boxConstraints;

  testWidgets(
    'Ticker provider vm mixin',
    (tester) async {
      final key = UniqueKey();
      final matrix4 = Matrix4.identity();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StateBuilder<_TestViewModel>(
              viewModel: viewModel,
              onSuccess: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: viewModel.animationController,
                      builder: (context, child) {
                        return Container(
                          alignment: FractionalOffset.center,
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
                    ),
                    AnimatedBuilder(
                      animation: viewModel.rotationAnimationController,
                      builder: (context, child) {
                        return Container(
                          key: key,
                          alignment: FractionalOffset.center,
                          transform: matrix4..rotateX(viewModel.tweenRotationAnimation.value),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(boxConstraints.maxHeight, 100.0);
      expect(boxConstraints.maxWidth, 100.0);
      final widget = tester.widget<Container>(find.byKey(key));

      expect(
        widget.transform,
        Matrix4(
          1,
          0,
          0,
          0,
          -0,
          -0.7071067811865441,
          0.7071067811865508,
          -0,
          0,
          -0.7071067811865508,
          -0.7071067811865441,
          0,
          0,
          0,
          0,
          1,
        ),
      );
    },
  );
}
