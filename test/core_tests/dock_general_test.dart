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

      expect(() => _TestViewModel2().onInit(StatelessElement(const _DummyStatelessWidget())), throwsAssertionError);
    },
  );
}

final class _TestViewModel extends BaseViewModel<_TestViewModel> {}

final class _TestViewModel2 extends BaseViewModel<_TestViewModel2> {}

final class _TestView extends BaseView<_TestViewModel> {
  _TestView() : super(viewModel: _TestViewModel());

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
      onEmpty: () => const Text('state: onEmpty'),
      onLoading: () => const Text('state: onLoading'),
      onOffline: () => const Text('state: onOffline'),
      onError: () => const Text('state: onError'),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const _Body();
  }
}

class _Body extends DockAccess<_TestViewModel> {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('state: onSuccess');
  }
}

class _DummyStatelessWidget extends StatelessWidget {
  const _DummyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
