import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel<_TestViewModel> {
  final counter = 0.observable;
  final alphabet = ['a', 'b', 'c'].observable;
}

void main() {
  testWidgets(
    'Reactive State Management',
    (tester) async {
      final viewModel = _TestViewModel();
      await tester.pumpWidget(
        Observer(
          builder: (context) => const SizedBox.shrink(),
        ),
      );
      expect(tester.takeException(), isInstanceOf<ObserverError>());

      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              Observer(
                builder: (context) => Text(
                  'Count: ${viewModel.counter.value}',
                ),
              ),
              Observer(
                builder: (context) => Text(
                  'Alphabet: ${viewModel.alphabet.value.last}',
                ),
              ),
            ],
          ),
        ),
      );

      viewModel.counter.value++;
      await tester.pump();
      expect(find.text('Count: 1'), findsOneWidget);
      viewModel.alphabet.update((alphabet) {
        alphabet.add('d');
      });
      await tester.pump();
      expect(find.text('Alphabet: d'), findsOneWidget);
    },
  );
}
