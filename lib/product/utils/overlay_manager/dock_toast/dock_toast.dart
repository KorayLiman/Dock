import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

part 'dock_toast_mixin.dart';

/// A pretty animated toast widget
class DockToast extends StatelessWidget with _DockToastDefaults {
  const DockToast({
    required this.controller,
    required this.message,
    required this.onDismissed,
    required this.position,
    super.key,
    this.title,
    this.titleStyle,
    this.messageStyle,
    this.child,
    this.leading,
    this.backgroundColor,
    this.shadowColor,
  });

  final String? title;
  final String? message;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;
  final Widget? child;
  final Widget? leading;
  final ToastPosition position;
  final Color? backgroundColor;
  final Color? shadowColor;
  final AnimationController controller;

  final ValueChanged<DismissDirection> onDismissed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      bottom: position.bottom,
      right: position.right,
      left: position.left,
      curve: Curves.elasticOut,
      duration: _repositioningDuration,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: onDismissed,
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: _toastBottomBeginOffset,
                  end: _toastBottomEndOffset,
                ).animate(
                  CurvedAnimation(
                    parent: controller,
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
                            const Blank(10),
                          ],
                          if (title.isNotNull || message.isNotNull)
                            Expanded(
                              child: Column(
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
