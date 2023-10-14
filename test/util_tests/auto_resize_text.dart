import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Auto Resize Widget Test',
    (tester) async {
      AutoResizeText.calculateResizeExecTime = true;
      const widget = AutoResizeText(
        'Accept',
        innerKey: ValueKey(0),
        maxLines: 1,
        style: TextStyle(fontSize: 60),
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: widget,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final textWidget = tester.widget<Text>(find.byKey(const ValueKey(0)));
      final textPainter = TextPainter(
        text: TextSpan(
          text: widget.data,
          style: textWidget.style,
          locale: widget.locale,
        ),
        textHeightBehavior: widget.textHeightBehavior,
        locale: widget.locale,
        textDirection: widget.textDirection ?? TextDirection.ltr,
        textWidthBasis: widget.textWidthBasis ?? TextWidthBasis.parent,
        textScaleFactor: widget.textScaleFactor ?? 1.0,
        textAlign: widget.textAlign ?? TextAlign.start,
        maxLines: widget.maxLines,
        strutStyle: widget.strutStyle,
      )..layout(maxWidth: 200);
      expect(textPainter.didExceedMaxLines, false);
    },
  );
}
