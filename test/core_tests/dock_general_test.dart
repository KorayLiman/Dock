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

      await tester.pumpWidget(
        MaterialApp(
          home: _TestView4(),
        ),
      );
      expect(find.byKey(_TestViewModel4._key), findsOneWidget);
      final testViewModel4 = Locator.find<_TestViewModel4>()..setPageState(PageState.empty);
      await tester.pump();
      expect(find.byKey(_TestViewModel4._key1), findsOneWidget);
      testViewModel4.setPageState(PageState.error);
      await tester.pump();
      expect(find.byKey(_TestViewModel4._key2), findsOneWidget);
      testViewModel4.setPageState(PageState.offline);
      await tester.pump();
      expect(find.byKey(_TestViewModel4._key3), findsOneWidget);
    },
  );
}

final class _TestViewModel extends BaseViewModel {}

final class _TestViewModel3 extends BaseViewModel {}

final class _TestViewModel4 extends BaseViewModel {
  static final _key = UniqueKey();
  static final _key1 = UniqueKey();
  static final _key2 = UniqueKey();
  static final _key3 = UniqueKey();

  @override
  void onInit() {
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
    setPageState(PageState.loading);
    super.onInit();
  }
}

final class _TestView extends BaseView<_TestViewModel> {
  _TestView() : super(viewModel: Locator.register(_TestViewModel()));

  @override
  Widget onSuccess(BuildContext context) {
    return const _Body();
  }

  @override
  Widget onEmpty(BuildContext context) => const Text('state: onEmpty');
  @override
  Widget onLoading(BuildContext context) => const Text('state: onLoading');
  @override
  Widget onOffline(BuildContext context) => const Text('state: onOffline');
  @override
  Widget onError(BuildContext context) => const Text('state: onError');
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
  _TestView3() : super(viewModel: Locator.register(_TestViewModel3()));

  @override
  Widget onSuccess(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('pop'),
      ),
    );
  }

  @override
  Widget onEmpty(BuildContext context) => const Text('state: onEmpty');
  @override
  Widget onLoading(BuildContext context) => const Text('state: onLoading');
  @override
  Widget onOffline(BuildContext context) => const Text('state: onOffline');
  @override
  Widget onError(BuildContext context) => const Text('state: onError');
}

final class _TestView4 extends BaseView<_TestViewModel4> {
  _TestView4() : super(viewModel: Locator.register(_TestViewModel4()));

  @override
  Widget onSuccess(BuildContext context) {
    return const Scaffold();
  }
}
