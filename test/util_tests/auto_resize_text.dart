import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore: avoid_void_async
void validate({required WidgetTester tester, required Widget widget, required double expectedFontSize}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: widget,
        ),
      ),
    ),
  );
  expect(nearEqual(tester.widget<Text>(find.byType(Text)).style?.fontSize, expectedFontSize, 0.5), true);
}

void main() {
  group(
    'Automatic resize test',
    () {
      AutoResizeText.calculateResizeExecTime = true;
      testWidgets(
        'Auto Shrink',
        (tester) async {
          validate(
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
        },
      );
    },
  );
}
