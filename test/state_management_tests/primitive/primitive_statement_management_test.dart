import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel<_TestViewModel> {
  int counter = 0;
  int counter2 = 0;
}

void main() {
  testWidgets(
    'Primitive State Management',
    (tester) async {
      final viewModel = _TestViewModel();
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              Docker(
                id: '0',
                viewModel: viewModel,
                builder: (context) => Text('${viewModel.counter}'),
              ),
              Docker(
                id: '1',
                viewModel: viewModel,
                builder: (context) => Text('${viewModel.counter2}'),
              ),
            ],
          ),
        ),
      );

      // UPDATE SINGLE
      viewModel.counter++;
      viewModel.update(id: '0');
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
      viewModel.updateAfter(
        id: '0',
        after: () {
          viewModel.counter++;
        },
      );
      await tester.pump();
      expect(find.text('2'), findsOneWidget);
      viewModel.counter++;
      viewModel.counter2++;
      viewModel.updateMany(ids: ['0', '1']);
      await tester.pump();
      expect(find.text('3'), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    },
  );
}
