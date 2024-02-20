import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Dock General Test',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: _TestView(),
        ),
      );

      final viewModel = Locator.find<_TestViewModel>();
      expect(viewModel.pageState, PageState.success);
      viewModel.setPageState(PageState.loading);
      await tester.pump();
      expect(find.text('state: onLoading'), findsOneWidget);
      viewModel.setPageState(PageState.empty);
      await tester.pump();
      expect(find.text('state: onEmpty'), findsOneWidget);
      viewModel.setPageState(PageState.error);
      await tester.pump();
      expect(find.text('state: onError'), findsOneWidget);
      viewModel.setPageState(PageState.offline);
      await tester.pump();
      expect(find.text('state: onOffline'), findsOneWidget);
      viewModel.setPageState(PageState.success);
      await tester.pump();
      expect(find.text('state: onSuccess'), findsOneWidget);
      await tester.tap(find.text('push'));
      await tester.pumpAndSettle();
      expect(Locator.tryFind<_TestViewModel3>(), isNotNull);
      await tester.tap(find.text('pop'));
      await tester.pumpAndSettle();
      expect(Locator.tryFind<_TestViewModel3>(), isNull);
      expect(() => _TestViewModel2().onInit(), throwsAssertionError);

      await tester.pumpWidget(
        MaterialApp(
          home: _TestView4(),
        ),
      );
      expect(find.byKey(_TestView4._key), findsOneWidget);
      final testViewModel4 = Locator.find<_TestViewModel4>()..setPageState(PageState.empty);
      await tester.pump();
      expect(find.byKey(_TestView4._key1), findsOneWidget);
      testViewModel4.setPageState(PageState.error);
      await tester.pump();
      expect(find.byKey(_TestView4._key2), findsOneWidget);
      testViewModel4.setPageState(PageState.offline);
      await tester.pump();
      expect(find.byKey(_TestView4._key3), findsOneWidget);
    },
  );
}

final class _TestViewModel extends BaseViewModel {}

final class _TestViewModel2 extends BaseViewModel {}

final class _TestViewModel3 extends BaseViewModel {}

final class _TestViewModel4 extends BaseViewModel {
  @override
  void onInit() {
    setPageState(PageState.loading);
    super.onInit();
  }
}

final class _TestView extends BaseView<_TestViewModel> {
  _TestView() : super(viewModel: _TestViewModel());

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<_TestViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => _onSuccess(context: context),
      onEmpty: (context) => const Text('state: onEmpty'),
      onLoading: (context) => const Text('state: onLoading'),
      onOffline: (context) => const Text('state: onOffline'),
      onError: (context) => const Text('state: onError'),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const _Body();
  }
}

class _Body extends DockStatelessWidget<_TestViewModel> {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('state: onSuccess'),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(builder: (context) => _TestView3()));
          },
          child: const Text('push'),
        ),
      ],
    );
  }
}

final class _TestView3 extends BaseView<_TestViewModel3> {
  _TestView3() : super(viewModel: _TestViewModel3());

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<_TestViewModel3>(
      viewModel: viewModel,
      onSuccess: (context) => _onSuccess(context: context),
      onEmpty: (context) => const Text('state: onEmpty'),
      onLoading: (context) => const Text('state: onLoading'),
      onOffline: (context) => const Text('state: onOffline'),
      onError: (context) => const Text('state: onError'),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('pop'),
      ),
    );
  }
}

final class _TestView4 extends BaseView<_TestViewModel4> {
  _TestView4() : super(viewModel: _TestViewModel4());

  static final _key = UniqueKey();
  static final _key1 = UniqueKey();
  static final _key2 = UniqueKey();
  static final _key3 = UniqueKey();

  @override
  StateBuilder build(BuildContext context) {
    Dock.defaultOnLoadingWidgetBuilder = (context) => CircularProgressIndicator(
          key: _key,
        );
    Dock.defaultOnEmptyWidgetBuilder = (context) => CircularProgressIndicator(
          key: _key1,
        );
    Dock.defaultOnErrorWidgetBuilder = (context) => CircularProgressIndicator(
          key: _key2,
        );
    Dock.defaultOnOfflineWidgetBuilder = (context) => CircularProgressIndicator(
          key: _key3,
        );
    return StateBuilder<_TestViewModel4>(
      viewModel: viewModel,
      onSuccess: (context) => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const Scaffold();
  }
}
