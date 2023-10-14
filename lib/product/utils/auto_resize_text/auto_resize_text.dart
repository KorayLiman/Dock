import 'package:dock/dock.dart';
import 'package:dock/product/utils/auto_resize_text/fit_behaviour.dart';
import 'package:flutter/material.dart';

@immutable
final class AutoResizeText extends StatelessWidget {
  const AutoResizeText(
    this.data, {
    super.key,
    this.innerKey,
    this.fitBehaviour = FitBehaviour.shrink,
    this.minFontSize = 12.0,
    this.maxFontSize = double.maxFinite,
    this.stepCoefficient = 1.0,
    this.locale,
    this.maxLines,
    this.overflow,
    this.selectionColor,
    this.semanticsLabel,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textDirection,
    this.textHeightBehavior,
    this.textScaleFactor,
    this.textWidthBasis,
  });

  final String? data;
  final Key? innerKey;
  final TextStyle? style;
  final FitBehaviour fitBehaviour;
  final double minFontSize;
  final double maxFontSize;
  final double stepCoefficient;
  final Locale? locale;
  final int? maxLines;
  final TextOverflow? overflow;
  final Color? selectionColor;
  final String? semanticsLabel;

  // final bool softWrap;
  final StrutStyle? strutStyle;

  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  @visibleForTesting
  static bool calculateResizeExecTime = false;

  static const _defaultFontSize = 14.0;

  void _validateProperties() {
    assert(maxFontSize > 0, 'Max font size cannot be zero or negative');
    assert(minFontSize > 0, 'Max font size cannot be zero or negative');
    assert(maxFontSize > minFontSize, 'Max font size cannot be zero or negative');
    // assert(minFontSize <= _currentStyle!.fontSize!, 'Min font size cannot be greater than font size');
    // assert(
    //   () {
    //     if (fitBehaviour == FitBehaviour.shrink) {
    //       if (_currentStyle!.fontSize! - minFontSize < stepCoefficient) {
    //         return false;
    //       }
    //     }
    //     return true;
    //   }(),
    //   '''
    // StepCoefficient is $stepCoefficient but fontSize - minFontSize = ${_currentStyle!.fontSize! - minFontSize}
    // which is lower than $stepCoefficient. Therefore cannot perform any step for resizing''',
    // );
    // assert(
    //   () {
    //     if (fitBehaviour == FitBehaviour.expand) {
    //       if (maxFontSize - _currentStyle!.fontSize! < stepCoefficient) {
    //         return false;
    //       }
    //     }
    //     return true;
    //   }(),
    //   '''
    // StepCoefficient is $stepCoefficient but maxFontSize - fontSize = ${maxFontSize - _currentStyle!.fontSize!}
    // which is lower than $stepCoefficient. Therefore cannot perform any step for resizing''',
    // );
  }

  ({double fontSize, int iterationCount}) _resizeIfNecessary({
    required BoxConstraints constraints,
    required DefaultTextStyle defaultStyle,
    required TextStyle currentStyle,
    required double defaultTextScaleFactor,
  }) {
    if (fitBehaviour == FitBehaviour.shrink) {
      if (_checkIfFits(currentStyle: currentStyle, defaultStyle: defaultStyle, defaultTextScaleFactor: defaultTextScaleFactor, constraints: constraints)) {
        return (fontSize: currentStyle.fontSize!, iterationCount: 0);
      } else {
        var iterationCount = 0;

        var min = minFontSize;
        var current = currentStyle.fontSize!;
        var max = currentStyle.fontSize!;
        while (true) {
          if (max - min < stepCoefficient) {
            current = min;
            break;
          }
          iterationCount++;
          current = (max + min) / 2;
          currentStyle = currentStyle.copyWith(fontSize: current);
          if (!_checkIfFits(currentStyle: currentStyle, defaultTextScaleFactor: defaultTextScaleFactor, defaultStyle: defaultStyle, constraints: constraints)) {
            max = current;
          } else {
            min = current;
          }
        }
        return (fontSize: current, iterationCount: iterationCount);
      }
    }
    return (fontSize: 0, iterationCount: 0);
  }

  bool _checkIfFits({required TextStyle currentStyle, required DefaultTextStyle defaultStyle, required double defaultTextScaleFactor, required BoxConstraints constraints}) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: data,
        style: currentStyle,
        locale: locale ?? defaultStyle.style.locale,
      ),
      locale: locale ?? defaultStyle.style.locale,
      textWidthBasis: textWidthBasis ?? defaultStyle.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? defaultStyle.textHeightBehavior,
      textDirection: textDirection ?? TextDirection.ltr,
      strutStyle: strutStyle,
      textScaleFactor: textScaleFactor ?? defaultTextScaleFactor,
      maxLines: maxLines ?? defaultStyle.maxLines,
      textAlign: textAlign ?? defaultStyle.textAlign ?? TextAlign.start,
    )..layout(maxWidth: constraints.maxWidth);

    final didFit = !(textPainter.didExceedMaxLines || textPainter.height > constraints.maxHeight || textPainter.width > constraints.maxWidth);
    // TODO(KorayLiman): This increases loop execution time. Needs to be considered again.
    textPainter.dispose();
    return didFit;
  }

  // void _tryToShrink({
  //   required TextPainter textPainter,
  //   required BoxConstraints constraints,
  //   required DefaultTextStyle defaultStyle,
  //   required double defaultTextScaleFactor,
  //   required double min,
  //   required double current,
  //   required double max,
  // }) {
  //   _iterationCount++;
  //   // if (!_checkIfFits(textPainter: textPainter, constraints: constraints)) {
  //   //   current = (max + min) / 2;
  //   //
  //   //   if (current - min < stepCoefficient) {
  //   //     _currentStyle = _currentStyle!.copyWith(fontSize: min);
  //   //     return;
  //   //   } else {
  //   //
  //   //     max = current;
  //   //     final newTextPainter = _createTextPainter(defaultStyle: defaultStyle, defaultTextScaleFactor: defaultTextScaleFactor)..layout(maxWidth: constraints.maxWidth);
  //   //     _tryToShrink(textPainter: newTextPainter, constraints: constraints, defaultStyle: defaultStyle, defaultTextScaleFactor: defaultTextScaleFactor, min: min, current: current, max: max);
  //   //   }
  //   // } else {
  //   //   if (max - current < stepCoefficient) {
  //   //     _currentStyle = _currentStyle!.copyWith(fontSize: current);
  //   //     return;
  //   //   }
  //   //   final newFontSize = (_currentStyle!.fontSize! + minSize) / 2;
  //   //   final newTextPainter = _createTextPainter(defaultStyle: defaultStyle, defaultTextScaleFactor: defaultTextScaleFactor)..layout(maxWidth: constraints.maxWidth);
  //   //   _tryToShrink(textPainter: newTextPainter, constraints: constraints, defaultStyle: defaultStyle, defaultTextScaleFactor: defaultTextScaleFactor, minSize: newFontSize);
  //   // }
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final defaultStyle = DefaultTextStyle.of(context);

        var currentStyle = style;

        if (data.isNotNull && data!.isNotEmpty) {
          if (currentStyle.isNull || currentStyle!.inherit) {
            currentStyle = defaultStyle.style.merge(currentStyle);
          }

          if (currentStyle.fontSize.isNull) {
            currentStyle = currentStyle.copyWith(fontSize: _defaultFontSize);
          }

          _validateProperties();
          Stopwatch? stopWatch;

          if (calculateResizeExecTime) {
            stopWatch = Stopwatch()..start();
          }

          final result = _resizeIfNecessary(
            constraints: constraints,
            defaultStyle: defaultStyle,
            currentStyle: currentStyle,
            defaultTextScaleFactor: MediaQuery.textScaleFactorOf(context),
          );
          currentStyle = currentStyle.copyWith(fontSize: result.fontSize);
          if (stopWatch.isNotNull) {
            stopWatch!.stop();
            print('''
            Exec time: ${stopWatch.elapsed.inMicroseconds} Microseconds.
            Iteration count: ${result.iterationCount}''');
          }
        }
        return Text(
          data ?? '',
          key: innerKey,
          style: currentStyle,
          maxLines: maxLines,
          overflow: overflow,
          textAlign: textAlign,
          locale: locale,
          selectionColor: selectionColor,
          semanticsLabel: semanticsLabel,
          softWrap: true,
          strutStyle: strutStyle,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textScaleFactor: textScaleFactor,
          textWidthBasis: textWidthBasis,
        );
      },
    );
  }
}
