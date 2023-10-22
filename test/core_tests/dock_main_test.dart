import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel<_TestViewModel> {
  final order = <int>[];

  @override
  void onInit(BuildContext element) {
    Dock
      ..registerPostFrameCallback((timeStamp) {
        order.add(0);
      })
      ..registerNextFrameCallback((timeStamp) {
        order.add(1);
      });
    super.onInit(element);
  }
}

final class _TestView extends BaseView<_TestViewModel> {
  _TestView({super.arguments, super.key}) : super(viewModel: _TestViewModel());

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const Scaffold();
  }
}

final class _TestViewModel2 extends BaseViewModel<_TestViewModel2> {
  final order = <int>[];

  @override
  void onInit(BuildContext element) {
    Dock.registerPostFrameCallback((timeStamp) {
      order.add(0);
    });
    final id = Dock.registerNextFrameCallback((timeStamp) {
      order.add(1);
    });
    Dock.cancelRegisteredFrameCallback(id);

    super.onInit(element);
  }
}

final class _TestView2 extends BaseView<_TestViewModel2> {
  _TestView2({super.arguments, super.key}) : super(viewModel: _TestViewModel2());

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const Scaffold();
  }
}

void main() {
  testWidgets(
    'Dock main test',
    (tester) async {
      Dock.testBindings = TestWidgetsFlutterBinding.ensureInitialized();
      final order = <int>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                Dock
                  ..registerPostFrameCallback((timeStamp) {
                    order.add(0);
                  })
                  ..registerNextFrameCallback((timeStamp) {
                    order.add(1);
                  });

                return const Text('_str');
              },
            ),
          ),
        ),
      );
      await tester.pump(500.milliseconds);
      expect(order[0] == 0 && order[1] == 1, true);
    },
  );
  testWidgets(
    'Dock main test2',
    (tester) async {
      Dock.testBindings = TestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _TestView(),
          ),
        ),
      );
      await tester.pump(500.milliseconds);
      expect(Locator.find<_TestViewModel>().order[0] == 0 && Locator.find<_TestViewModel>().order[1] == 1, true);
    },
  );
  testWidgets(
    'Dock main test3',
    (tester) async {
      Dock.testBindings = TestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: _TestView2(),
          ),
        ),
      );
      await tester.pump(500.milliseconds);
      expect(Locator.find<_TestViewModel2>().order.length, 1);
    },
  );

  test(
    'Throw Conditional Test',
    () async {
      expect(() => Dock.throwConditional(exception: Exception(), throwIf: true), throwsException);
    },
  );
}
