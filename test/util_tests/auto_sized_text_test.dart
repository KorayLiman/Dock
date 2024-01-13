import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'AutoSizedText widget test',
    () {
      debugPrint('*** AutoSizedText widget test begin ***\n');
      testWidgets('Auto Shrink', (tester) async {
        await _validate(
          tester: tester,
          widget: const SizedBox(
            height: 200,
            width: 200,
            child: AutoSizedText(
              'Accept',
              maxLines: 1,
              style: TextStyle(fontSize: 80),
            ),
          ),
          expectedFontSize: 33,
        );
      });
      testWidgets('Auto Shrink', (tester) async {
        await _validate(
          tester: tester,
          widget: const SizedBox(
            height: 200,
            width: 350,
            child: AutoSizedText(
              'Accept',
              maxLines: 1,
              style: TextStyle(fontSize: 500),
            ),
          ),
          expectedFontSize: 57.75,
        );
      });

      testWidgets('Auto Shrink', (tester) async {
        await _validate(
          tester: tester,
          widget: const SizedBox(
            height: 200,
            width: 350,
            child: AutoSizedText(
              'Accept',
              maxLines: 1,
              minFontSize: 100,
              style: TextStyle(fontSize: 500),
            ),
          ),
          expectedFontSize: 100,
        );
      });
      testWidgets('Auto Shrink', (tester) async {
        await _validate(
          tester: tester,
          widget: SizedBox(
            height: 200,
            width: 350,
            child: AutoSizedText(
              'Accept' * 99,
              maxLines: 2,
              style: const TextStyle(fontSize: 500),
            ),
          ),
          expectedFontSize: 12,
        );
      });
      testWidgets(
        'Auto Shrink',
        (tester) async {
          await _validate(
            tester: tester,
            widget: SizedBox(
              height: 200,
              width: 350,
              child: AutoSizedText(
                'Accept' * 5,
                maxLines: 3,
                minFontSize: 24,
                style: const TextStyle(fontSize: 60),
              ),
            ),
            expectedFontSize: 34.68,
          );
        },
      );
    },
  );
}

Future<void> _validate({required WidgetTester tester, required Widget widget, required double expectedFontSize}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: widget,
        ),
      ),
    ),
  );
  final astWidget = tester.widget<AutoSizedText>(find.byType(AutoSizedText));
  final renderObject = tester.renderObject<ASTRenderObject>(find.byType(AutoSizedText));
  final fontSize = renderObject.style.fontSize!;
  final result = nearEqual(fontSize, expectedFontSize, 1);
  tester
    ..printToConsole('begin fontSize: ${astWidget.style?.fontSize} <-> final fontSize: $fontSize <-> expected fontSize: $expectedFontSize')
    ..printToConsole('Result: ${result ? 'Passed' : 'Failed'}');
  expect(nearEqual(fontSize, expectedFontSize, 1), true);
}
