import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

typedef ToastPositionRecord = ({double? top, double? bottom, double? left, double? right});

/// A pretty animated toast widget
class DockToast extends StatelessWidget {
  const DockToast({
    required this.slideAnimationController,
    required this.message,
    required this.onDismissed,
    required this.toastPosition,
    super.key,
    this.title,
    this.titleStyle,
    this.messageStyle,
    this.messageMaxLines,
    this.dismissDirection,
    this.child,
    this.leading,
    this.backgroundColor,
    this.shadowColor,
  });

  final String? title;
  final String? message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final int? messageMaxLines;
  final DismissDirection? dismissDirection;
  final Widget? child;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? shadowColor;
  final AnimationController slideAnimationController;
  final ToastPosition toastPosition;
  final ValueChanged<DismissDirection> onDismissed;

  /// Default forward animation curve
  Cubic get _forwardAnimCurve => const Cubic(0.1, 0.8, 0.2, 1.275);

  /// Default reverse animation curve
  Cubic get _reverseAnimCurve => const Cubic(0.1, 0.8, 0.2, 1.100);

  /// Default padding of toast
  EdgeInsets get _toastPadding => const EdgeInsets.symmetric(horizontal: 16, vertical: 20);

  /// Default bottom toast animation begin offset
  Offset get _toastBeginOffset => toastPosition == ToastPosition.bottom ? const Offset(0, 2) : const Offset(0, -2);

  /// Default bottom toast animation end offset
  Offset get _toastEndOffset => Offset.zero;

  /// Default toast radius
  BorderRadius get _toastBorderRadius => BorderRadius.circular(15);

  /// Default toast color
  Color get _defaultToastColor => Colors.grey.shade400;

  /// Default shadow color
  Color get _defaultShadowColor => Colors.grey.shade400;

  /// Default above shadow offset
  Offset get _defaultToastShadowAboveOffset => const Offset(0, -1);

  /// Default below shadow offset
  Offset get _defaultTShadowBelowOffset => const Offset(0, 7);

  /// Default title text style
  TextStyle get _defaultTitleStyle => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  /// Default message text style
  TextStyle get _defaultMessageStyle => const TextStyle(color: Colors.white);

  /// Default above shadow radius
  double get _defaultAboveShadowRadius => 0.5;

  /// Default below shadow radius
  double get _defaultBelowShadowRadius => 12;

  /// Dart record instance of toast position
  ToastPositionRecord _toastPositionRecord(BuildContext context) => toastPosition == ToastPosition.bottom ? (top: null, bottom: 40, left: 10, right: 10) : (top: context.viewPadding.top, bottom: null, left: 10, right: 10);

  @override
  Widget build(BuildContext context) {
    final position = _toastPositionRecord(context);
    return Positioned(
      bottom: position.bottom,
      right: position.right,
      left: position.left,
      top: position.top,
      child: AnimatedBuilder(
        animation: slideAnimationController,
        builder: (context, _) {
          return Dismissible(
            key: UniqueKey(),
            direction: dismissDirection ?? DismissDirection.horizontal,
            onDismissed: onDismissed,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: _toastBeginOffset,
                  end: _toastEndOffset,
                ).animate(
                  CurvedAnimation(
                    parent: slideAnimationController,
                    curve: _forwardAnimCurve,
                    reverseCurve: _reverseAnimCurve,
                  ),
                ),
                child: Container(
                  width: context.width,
                  padding: _toastPadding,
                  decoration: BoxDecoration(
                    color: backgroundColor ?? _defaultToastColor,
                    borderRadius: _toastBorderRadius,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: _defaultAboveShadowRadius,
                        offset: _defaultToastShadowAboveOffset,
                        color: shadowColor ?? _defaultShadowColor,
                      ),
                      BoxShadow(
                        blurRadius: _defaultBelowShadowRadius,
                        offset: _defaultTShadowBelowOffset,
                        color: shadowColor ?? _defaultShadowColor,
                      ),
                    ],
                  ),
                  child: child ??
                      Row(
                        children: [
                          if (leading.isNotNull) ...[
                            leading!,
                            const Gap(10),
                          ],
                          if (title.isNotNull || message.isNotNull)
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (title.isNotNull)
                                    Text(
                                      title!,
                                      style: titleStyle ?? _defaultTitleStyle,
                                    ),
                                  if (message.isNotNull)
                                    Text(
                                      message!,
                                      style: messageStyle ?? _defaultMessageStyle,
                                      maxLines: messageMaxLines,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
