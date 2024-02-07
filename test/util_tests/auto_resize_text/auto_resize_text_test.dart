import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_test/flutter_test.dart';

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
  final fontSize = tester.widget<Text>(find.byType(Text)).style!.fontSize!;
  tester.printToConsole('fontSize: $fontSize Expected: $expectedFontSize');
  expect(nearEqual(fontSize, expectedFontSize, 0.1), true);
}

void main() {
  group(
    'Automatic resize test',
    () {
      AutoResizeText.calculateResizeExecTime = true;
      testWidgets(
        'Auto Shrink',
        (tester) async {
          await _validate(
            tester: tester,
            widget: const SizedBox(
              height: 200,
              width: 200,
              child: AutoResizeText(
                'Accept',
                maxLines: 1,
                style: TextStyle(fontSize: 60),
              ),
            ),
            expectedFontSize: 33,
          );

          await _validate(
            tester: tester,
            widget: const SizedBox(
              height: 200,
              width: 350,
              child: AutoResizeText(
                'Accept',
                maxLines: 1,
                style: TextStyle(fontSize: 500),
              ),
            ),
            expectedFontSize: 57.75,
          );
          await _validate(
            tester: tester,
            widget: const SizedBox(
              height: 200,
              width: 350,
              child: AutoResizeText(
                'Accept',
                maxLines: 1,
                minFontSize: 100,
                style: TextStyle(fontSize: 500),
              ),
            ),
            expectedFontSize: 100,
          );
          await _validate(
            tester: tester,
            widget: SizedBox(
              height: 200,
              width: 350,
              child: AutoResizeText(
                'Accept' * 99,
                maxLines: 2,
                style: const TextStyle(fontSize: 500),
              ),
            ),
            expectedFontSize: 12,
          );
          await _validate(
            tester: tester,
            widget: SizedBox(
              height: 200,
              width: 350,
              child: AutoResizeText(
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
