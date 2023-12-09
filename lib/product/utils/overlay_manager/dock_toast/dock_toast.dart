import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

part 'dock_toast_mixin.dart';

/// A pretty animated toast widget
class DockToast extends StatelessWidget with _DockToastMixin {
  const DockToast({
    required this.controller,
    super.key,
    this.title,
    this.message,
    this.leading,
    this.backgroundColor,
    this.shadowColor,
    this.child,
    this.position = DockToastPosition.bottom,
  });

  final String? title;
  final String? message;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? shadowColor;
  final AnimationController controller;
  final Widget? child;
  final DockToastPosition position;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: position == DockToastPosition.bottom ? _toastBottomBeginOffset : _toastTopBeginOffset,
            end: position == DockToastPosition.bottom ? _toastBottomEndOffset : _toastTopEndOffset,
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
              // boxShadow: [
              //
              // ]
            ),
            child: child ??
                Row(
                  children: [
                    if (leading != null) ...[
                      leading!,
                      const Blank(10),
                    ],
                    if (message != null)
                      Expanded(
                        child: Text(
                          message!,
                        ),
                      ),
                  ],
                ),
          ),
        );
      },
    );
  }
}
