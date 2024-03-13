import 'dart:ui' as ui;

import 'package:dock_flutter/src/product/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// ignore_for_file: no_leading_underscores_for_local_identifiers

/// Unicode of character  ...  (three dots)
const _kEllipsis = '\u2026';

/// Minimum allowed font size of text
const _kMinFontSize = 12.0;

/// Default font size of text
const _defaultFontSize = 14.0;

typedef _TextConfiguration = ({
  TextStyle style,
  TextScaler textScaler,
  TextAlign textAlign,
  TextDirection textDirection,
  int? maxLines,
  TextWidthBasis textWidthBasis,
  TextHeightBehavior? textHeightBehavior,
  TextOverflow overflow,
  Locale? locale,
});

// TODO(KorayLiman): Add documentation, Tests, and examples, softWrap feature, AutoSizedText.rich feature
class AutoSizedText extends LeafRenderObjectWidget {
  const AutoSizedText(
    this.data, {
    super.key,
    this.minFontSize = _kMinFontSize,
    this.locale,
    this.iterationCoefficient = 1.0,
    this.textDirection,
    this.textScaler,
    this.maxLines,
    this.overflow,
    this.strutStyle,
    this.style,
    this.textAlign,
    this.textHeightBehavior,
    this.textWidthBasis,
  }) : assert(minFontSize > 0, 'Min font size cannot be zero or negative');

  final String? data;
  final TextStyle? style;
  final double minFontSize;
  final double iterationCoefficient;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  _TextConfiguration _textConfiguration(BuildContext context) {
    final defaultTextStyle = context.dependOn.defaultTextStyle;
    var effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (context.dependOn.usingBoldText) {
      effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    if (effectiveTextStyle!.fontSize.isNull) {
      effectiveTextStyle = effectiveTextStyle.merge(const TextStyle(fontSize: _defaultFontSize));
    }

    final _textScaler = textScaler ?? context.dependOn.textScaler;
    final _textDirection = textDirection ?? context.dependOn.directionality;
    final _textWidthBasis = textWidthBasis ?? defaultTextStyle.textWidthBasis;
    final _textHeightBehavior = textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context);
    final _maxLines = maxLines ?? defaultTextStyle.maxLines;
    final _overflow = overflow ?? effectiveTextStyle.overflow ?? defaultTextStyle.overflow;
    final _textAlign = textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final _locale = locale ?? context.dependOn.maybeLocale;

    return (
      style: effectiveTextStyle,
      textScaler: _textScaler,
      textAlign: _textAlign,
      textDirection: _textDirection,
      maxLines: _maxLines,
      textWidthBasis: _textWidthBasis,
      textHeightBehavior: _textHeightBehavior,
      overflow: _overflow,
      locale: _locale,
    );
  }

  @override
  ASTRenderObject createRenderObject(BuildContext context) {
    final textConfig = _textConfiguration(context);
    return ASTRenderObject(
      text: data,
      style: textConfig.style,
      textAlign: textConfig.textAlign,
      textDirection: textConfig.textDirection,
      textScaler: textConfig.textScaler,
      locale: textConfig.locale,
      textWidthBasis: textConfig.textWidthBasis,
      textHeightBehavior: textConfig.textHeightBehavior,
      strutStyle: strutStyle,
      maxLines: textConfig.maxLines,
      overflow: textConfig.overflow,
      minFontSize: minFontSize,
      iterationCoefficient: iterationCoefficient,
    );
  }

  void _updateAstRenderObject(
    BuildContext context,
    ASTRenderObject renderObject,
  ) {
    final textConfig = _textConfiguration(context);
    renderObject
      ..text = data
      ..style = textConfig.style
      ..textAlign = textConfig.textAlign
      ..textDirection = textConfig.textDirection
      ..textScaler = textConfig.textScaler
      ..locale = textConfig.locale
      ..textWidthBasis = textConfig.textWidthBasis
      ..textHeightBehavior = textConfig.textHeightBehavior
      ..strutStyle = strutStyle
      ..maxLines = textConfig.maxLines
      ..overflow = textConfig.overflow
      ..minFontSize = minFontSize
      ..iterationCoefficient = iterationCoefficient;
    renderObject._textPainter
      ..text = TextSpan(
        text: data,
        style: textConfig.style,
      )
      ..textAlign = textConfig.textAlign
      ..textDirection = textConfig.textDirection
      ..textScaler = textConfig.textScaler
      ..locale = textConfig.locale
      ..textWidthBasis = textConfig.textWidthBasis
      ..textHeightBehavior = textConfig.textHeightBehavior
      ..strutStyle = strutStyle
      ..maxLines = textConfig.maxLines
      ..ellipsis = textConfig.overflow == TextOverflow.ellipsis ? _kEllipsis : null;
    renderObject
      ..markNeedsLayout()
      ..markNeedsSemanticsUpdate();
  }

  @override
  void updateRenderObject(BuildContext context, ASTRenderObject renderObject) {
    _updateAstRenderObject(context, renderObject);
  }
}

final class ASTRenderObject extends RenderBox with RelayoutWhenSystemFontsChangeMixin {
  ASTRenderObject({
    required this.text,
    required this.style,
    required this.textAlign,
    required this.textDirection,
    required this.textScaler,
    required this.maxLines,
    required this.locale,
    required this.strutStyle,
    required this.textWidthBasis,
    required this.textHeightBehavior,
    required this.overflow,
    required this.minFontSize,
    required this.iterationCoefficient,
  }) : _textPainter = TextPainter(
          text: TextSpan(
            text: text,
            style: style,
          ),
          textAlign: textAlign,
          textDirection: textDirection,
          textScaler: textScaler,
          maxLines: maxLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
          strutStyle: strutStyle,
          textWidthBasis: textWidthBasis,
          textHeightBehavior: textHeightBehavior,
        );

  final TextPainter _textPainter;

  double minFontSize;
  String? text;
  TextStyle style;
  TextAlign textAlign;
  TextDirection textDirection;
  TextScaler textScaler;
  int? maxLines;
  Locale? locale;
  StrutStyle? strutStyle;
  TextWidthBasis textWidthBasis;
  TextHeightBehavior? textHeightBehavior;
  TextOverflow overflow;
  double iterationCoefficient;

  bool _needsClipping = false;
  ui.Shader? _overflowShader;
  int _iterationCount = 0;

  @override
  void dispose() {
    _textPainter.dispose();
    super.dispose();
  }

  @override
  void systemFontsDidChange() {
    super.systemFontsDidChange();
    _textPainter.markNeedsLayout();
  }

  bool get _checkIfOverflowsFromAllAxis {
    return _textPainter.didExceedMaxLines || _textPainter.height > constraints.maxHeight || _textPainter.width > constraints.maxWidth;
  }

  bool get _didOverflowWidth => constraints.maxWidth < _textPainter.width;

  @override
  void performLayout() {
    _iterationCount = 0;
    _textPainter.layout(maxWidth: constraints.maxWidth);
    var min = minFontSize;
    var max = style.fontSize!;
    var current = style.fontSize!;
    if (_checkIfOverflowsFromAllAxis) {
      while (true) {
        _iterationCount++;

        if (max - min < iterationCoefficient) {
          style = style.copyWith(fontSize: min);
          _textPainter
            ..text = TextSpan(
              text: text,
              style: style,
            )
            ..layout(maxWidth: constraints.maxWidth);
          break;
        }
        current = (max + min) / 2;
        style = style.copyWith(fontSize: current);

        _textPainter
          ..text = TextSpan(
            text: text,
            style: style,
          )
          ..layout(maxWidth: constraints.maxWidth);

        if (_checkIfOverflowsFromAllAxis) {
          max = current;
        } else {
          min = current;
        }
      }
    }
    size = constraints.constrain(_textPainter.size);

    if (_checkIfOverflowsFromAllAxis) {
      switch (overflow) {
        case TextOverflow.visible:
          _needsClipping = false;
          _overflowShader = null;
        case TextOverflow.clip:
        case TextOverflow.ellipsis:
          _needsClipping = true;
          _overflowShader = null;
        case TextOverflow.fade:
          _needsClipping = true;
          final fadeSizePainter = TextPainter(
            text: TextSpan(style: _textPainter.text!.style, text: '\u2026'),
            textDirection: textDirection,
            textScaler: textScaler,
            locale: locale,
          )..layout(maxWidth: constraints.maxWidth);
          if (_didOverflowWidth) {
            double fadeEnd;
            double fadeStart;
            switch (textDirection) {
              case TextDirection.rtl:
                fadeEnd = 0.0;
                fadeStart = fadeSizePainter.width;
              case TextDirection.ltr:
                fadeEnd = size.width;
                fadeStart = fadeEnd - fadeSizePainter.width;
            }
            _overflowShader = ui.Gradient.linear(
              Offset(fadeStart, 0),
              Offset(fadeEnd, 0),
              <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
            );
          } else {
            final fadeEnd = size.height;
            final fadeStart = fadeEnd - fadeSizePainter.height / 2.0;
            _overflowShader = ui.Gradient.linear(
              Offset(0, fadeStart),
              Offset(0, fadeEnd),
              <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
            );
          }
          fadeSizePainter.dispose();
      }
    } else {
      _needsClipping = false;
      _overflowShader = null;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_needsClipping) {
      final bounds = offset & size;
      if (_overflowShader != null) {
        context.canvas.saveLayer(bounds, Paint());
      } else {
        context.canvas.save();
      }
      context.canvas.clipRect(bounds);
    }
    _textPainter.paint(context.canvas, offset);

    if (_needsClipping) {
      if (_overflowShader != null) {
        context.canvas.translate(offset.dx, offset.dy);
        final paint = Paint()
          ..blendMode = BlendMode.modulate
          ..shader = _overflowShader;
        context.canvas.drawRect(Offset.zero & size, paint);
      }
      context.canvas.restore();
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..textDirection = textDirection
      ..value = text ?? ''
      ..label = 'AutoSizedText';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<TextAlign>('textAlign', textAlign, defaultValue: TextAlign.start))
      ..add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null))
      //..add(FlagProperty('softWrap', value: softWrap, ifTrue: 'wrapping at box width', ifFalse: 'no wrapping except at line break characters', showName: true))
      ..add(EnumProperty<TextOverflow>('overflow', overflow, defaultValue: TextOverflow.clip))
      ..add(DiagnosticsProperty<TextScaler>('textScaler', textScaler, defaultValue: TextScaler.noScaling))
      ..add(IntProperty('maxLines', maxLines, ifNull: 'unlimited'))
      ..add(DoubleProperty('minFontSize', minFontSize))
      ..add(DoubleProperty('iterationCoefficient', iterationCoefficient))
      ..add(IntProperty('iteration count', _iterationCount))
      ..add(EnumProperty<TextWidthBasis>('textWidthBasis', textWidthBasis, defaultValue: TextWidthBasis.parent))
      ..add(StringProperty('text', _textPainter.text!.toPlainText()))
      ..add(DiagnosticsProperty<Locale>('locale', locale, defaultValue: null))
      ..add(DiagnosticsProperty<StrutStyle>('strutStyle', strutStyle, defaultValue: null))
      ..add(DiagnosticsProperty<TextHeightBehavior>('textHeightBehavior', textHeightBehavior, defaultValue: null))
      ..add(DiagnosticsProperty('style', style, defaultValue: null));
  }
}
