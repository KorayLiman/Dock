import 'package:dock_flutter/product/product.dart';
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

class AutoSizedText extends LeafRenderObjectWidget {
  const AutoSizedText(
    this.data, {
    super.key,
    this.minFontSize = _kMinFontSize,
    this.locale,
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
    final defaultTextStyle = context.defaultTextStyle;
    var effectiveTextStyle = style;
    if (style == null || style!.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(style);
    }
    if (context.usingBoldText) {
      effectiveTextStyle = effectiveTextStyle!
          .merge(const TextStyle(fontWeight: FontWeight.bold));
    }
    if (effectiveTextStyle!.fontSize.isNull) {
      effectiveTextStyle =
          effectiveTextStyle.merge(const TextStyle(fontSize: _defaultFontSize));
    }

    final _textScaler = textScaler ?? context.textScaler;
    final _textDirection = textDirection ?? context.directionality;
    final _textWidthBasis = textWidthBasis ?? defaultTextStyle.textWidthBasis;
    final _textHeightBehavior = textHeightBehavior ??
        defaultTextStyle.textHeightBehavior ??
        DefaultTextHeightBehavior.maybeOf(context);
    final _maxLines = maxLines ?? defaultTextStyle.maxLines;
    final _overflow =
        overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow;
    final _textAlign =
        textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final _locale = locale ?? context.maybeLocale;

    return (
      style: effectiveTextStyle!,
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
      ..minFontSize = minFontSize;
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
      ..ellipsis =
          textConfig.overflow == TextOverflow.ellipsis ? _kEllipsis : null;
  }

  @override
  void updateRenderObject(BuildContext context, ASTRenderObject renderObject) {
    _updateAstRenderObject(context, renderObject);
  }
}

final class ASTRenderObject extends RenderBox
    with RelayoutWhenSystemFontsChangeMixin {
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

  bool get _checkIfOverflows {
    return _textPainter.didExceedMaxLines ||
        _textPainter.height > constraints.maxHeight ||
        _textPainter.width > constraints.maxWidth;
  }

  @override
  void performLayout() {
    _textPainter.layout(maxWidth: constraints.maxWidth);
    while (_checkIfOverflows && style.fontSize! > minFontSize) {
      style = style.copyWith(fontSize: style.fontSize! - 1);
      _textPainter
        ..text = TextSpan(
          text: text,
          style: style,
        )
        ..layout(maxWidth: constraints.maxWidth);
    }
    size = constraints.constrain(_textPainter.size);
/*
  final bool hasVisualOverflow = didOverflowWidth || didOverflowHeight;
    if (hasVisualOverflow) {
      switch (_overflow) {
        case TextOverflow.visible:
          _needsClipping = false;
          _overflowShader = null;
        case TextOverflow.clip:
        case TextOverflow.ellipsis:
          _needsClipping = true;
          _overflowShader = null;
        case TextOverflow.fade:
          _needsClipping = true;
          final TextPainter fadeSizePainter = TextPainter(
            text: TextSpan(style: _textPainter.text!.style, text: '\u2026'),
            textDirection: textDirection,
            textScaler: textScaler,
            locale: locale,
          )..layout();
          if (didOverflowWidth) {
            double fadeEnd, fadeStart;
            switch (textDirection) {
              case TextDirection.rtl:
                fadeEnd = 0.0;
                fadeStart = fadeSizePainter.width;
              case TextDirection.ltr:
                fadeEnd = size.width;
                fadeStart = fadeEnd - fadeSizePainter.width;
            }
            _overflowShader = ui.Gradient.linear(
              Offset(fadeStart, 0.0),
              Offset(fadeEnd, 0.0),
              <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
            );
          } else {
            final double fadeEnd = size.height;
            final double fadeStart = fadeEnd - fadeSizePainter.height / 2.0;
            _overflowShader = ui.Gradient.linear(
              Offset(0.0, fadeStart),
              Offset(0.0, fadeEnd),
              <Color>[const Color(0xFFFFFFFF), const Color(0x00FFFFFF)],
            );
          }
          fadeSizePainter.dispose();
      }
    } else {
      _needsClipping = false;
      _overflowShader = null;
    }
*/
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    config
      ..textDirection = textDirection
      ..value = text ?? ''
      ..label = 'AutoSizedText';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        EnumProperty<TextAlign>(
          'textAlign',
          textAlign,
          defaultValue: TextAlign.start,
        ),
      )
      ..add(
        EnumProperty<TextDirection>(
          'textDirection',
          textDirection,
          defaultValue: null,
        ),
      )
      //..add(FlagProperty('softWrap', value: softWrap, ifTrue: 'wrapping at box width', ifFalse: 'no wrapping except at line break characters', showName: true))
      ..add(
        EnumProperty<TextOverflow>(
          'overflow',
          overflow,
          defaultValue: TextOverflow.clip,
        ),
      )
      ..add(
        DiagnosticsProperty<TextScaler>(
          'textScaler',
          textScaler,
          defaultValue: TextScaler.noScaling,
        ),
      )
      ..add(
        IntProperty('maxLines', maxLines, ifNull: 'unlimited'),
      )
      ..add(
        EnumProperty<TextWidthBasis>(
          'textWidthBasis',
          textWidthBasis,
          defaultValue: TextWidthBasis.parent,
        ),
      )
      ..add(
        StringProperty('text', _textPainter.text!.toPlainText()),
      )
      ..add(
        DiagnosticsProperty<Locale>('locale', locale, defaultValue: null),
      )
      ..add(
        DiagnosticsProperty<StrutStyle>(
          'strutStyle',
          strutStyle,
          defaultValue: null,
        ),
      )
      ..add(
        DiagnosticsProperty<TextHeightBehavior>(
          'textHeightBehavior',
          textHeightBehavior,
          defaultValue: null,
        ),
      );
  }
}

//
// @immutable
// class AutoSizedText extends StatelessWidget {
//   const AutoSizedText(
//     this.data, {
//     super.key,
//     this.style,
//     this.textAlign = TextAlign.start,
//     this.textDirection,
//     this.semanticsLabel,
//     this.softWrap = true,
//     this.overflow = TextOverflow.clip,
//     this.textScaler = TextScaler.noScaling,
//     this.maxLines,
//     this.locale,
//     this.strutStyle,
//     this.textWidthBasis = TextWidthBasis.parent,
//     this.textHeightBehavior,
//     this.selectionRegistrar,
//     this.selectionColor,
//   }) : textSpan = null;
//
//   final String? data;
//   final TextStyle? style;
//   final TextAlign textAlign;
//   final TextDirection? textDirection;
//   final bool softWrap;
//   final InlineSpan? textSpan;
//   final TextOverflow overflow;
//   final TextScaler textScaler;
//   final int? maxLines;
//   final Locale? locale;
//   final StrutStyle? strutStyle;
//   final TextWidthBasis textWidthBasis;
//   final TextHeightBehavior? textHeightBehavior;
//   final SelectionRegistrar? selectionRegistrar;
//   final Color? selectionColor;
//   final String? semanticsLabel;
//
//   @override
//   Widget build(BuildContext context) {
//     final defaultTextStyle = DefaultTextStyle.of(context);
//     var effectiveTextStyle = style;
//     if (style == null || style!.inherit) {
//       effectiveTextStyle = defaultTextStyle.style.merge(style);
//     }
//     if (MediaQuery.boldTextOf(context)) {
//       effectiveTextStyle = effectiveTextStyle!.merge(const TextStyle(fontWeight: FontWeight.bold));
//     }
//     final registrar = SelectionContainer.maybeOf(context);
//
//     Widget result = AutoSizedRichTextWidget(
//       textAlign: textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start,
//       textDirection: textDirection,
//       // RichText uses Directionality.of to obtain a default if this is null.
//       locale: locale,
//       // RichText uses Localizations.localeOf to obtain a default if this is null
//       softWrap: softWrap ?? defaultTextStyle.softWrap,
//       overflow: overflow ?? effectiveTextStyle?.overflow ?? defaultTextStyle.overflow,
//       textScaler: textScaler,
//       maxLines: maxLines ?? defaultTextStyle.maxLines,
//       strutStyle: strutStyle,
//       textWidthBasis: textWidthBasis ?? defaultTextStyle.textWidthBasis,
//       textHeightBehavior: textHeightBehavior ?? defaultTextStyle.textHeightBehavior ?? DefaultTextHeightBehavior.maybeOf(context),
//       selectionRegistrar: registrar,
//       selectionColor: selectionColor ?? DefaultSelectionStyle.of(context).selectionColor ?? DefaultSelectionStyle.defaultColor,
//       text: TextSpan(
//         style: effectiveTextStyle,
//         text: data,
//         children: textSpan != null ? <InlineSpan>[textSpan!] : null,
//       ),
//     );
//     if (registrar != null) {
//       result = MouseRegion(
//         cursor: DefaultSelectionStyle.of(context).mouseCursor ?? SystemMouseCursors.text,
//         child: result,
//       );
//     }
//     if (semanticsLabel != null) {
//       result = Semantics(
//         textDirection: textDirection,
//         label: semanticsLabel,
//         child: ExcludeSemantics(
//           child: result,
//         ),
//       );
//     }
//     return result;
//   }
// }
//
// final class AutoSizedRichTextWidget extends RichText {
//   @visibleForTesting
//   AutoSizedRichTextWidget({
//     required TextSpan super.text,
//     super.key,
//     super.textAlign,
//     super.textDirection,
//     super.softWrap,
//     super.overflow,
//     super.maxLines,
//     super.locale,
//     super.strutStyle,
//     super.textWidthBasis,
//     super.textHeightBehavior,
//     super.selectionRegistrar,
//     super.selectionColor,
//     super.textScaler,
//   });
//
//   @override
//   AutoSizedTextRenderParagraph createRenderObject(BuildContext context) {
//     return AutoSizedTextRenderParagraph(
//       text,
//       textDirection: textDirection ?? Directionality.of(context),
//       textAlign: textAlign,
//       softWrap: softWrap,
//       overflow: overflow,
//       maxLines: maxLines,
//       locale: locale,
//       strutStyle: strutStyle,
//       textWidthBasis: textWidthBasis,
//       textHeightBehavior: textHeightBehavior,
//       registrar: selectionRegistrar,
//       selectionColor: selectionColor,
//       textScaler: textScaler,
//     );
//   }
// }
//
// final class AutoSizedTextRenderParagraph extends RenderParagraph {
//   AutoSizedTextRenderParagraph(
//     super.text, {
//     required super.textDirection,
//     super.overflow,
//     super.maxLines,
//     super.locale,
//     super.strutStyle,
//     super.textWidthBasis,
//     super.textHeightBehavior,
//     super.selectionColor,
//     super.textScaler,
//     super.textAlign,
//     super.softWrap,
//     super.registrar,
//   });
//
//   final String _kEllipsis = '\u2026';
//
//   @override
//   void performLayout() {
//     final parentConstraints = parent?.constraints as BoxConstraints?;
//     assert(parentConstraints.isNotNull, 'AutoSizedText has no constrained parent');
//     final temporaryTextPainter = TextPainter(
//       text: text,
//       textAlign: textAlign,
//       textDirection: textDirection,
//       textScaler: textScaler,
//       maxLines: maxLines,
//       ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
//       locale: locale,
//       strutStyle: strutStyle,
//       textWidthBasis: textWidthBasis,
//       textHeightBehavior: textHeightBehavior,
//     )..layout(maxWidth: parentConstraints!.maxWidth);
//     var existingSpan = text as TextSpan;
//     while (temporaryTextPainter.didExceedMaxLines) {
//       final newSpan = TextSpan(
//         text: existingSpan.text,
//         style: existingSpan.style!.copyWith(fontSize: existingSpan.style!.fontSize! - 1),
//         children: existingSpan.children,
//       );
//       existingSpan = newSpan;
//       temporaryTextPainter
//         ..text = existingSpan
//         ..layout(maxWidth: parentConstraints.maxWidth);
//     }
//     temporaryTextPainter.dispose();
//     text = existingSpan;
//     super.performLayout();
//   }
// }
