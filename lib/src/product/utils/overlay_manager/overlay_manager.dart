import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// [PositionedBuilder]
typedef PositionedBuilder = Positioned Function(BuildContext context);

/// Record holds [OverlayEntry] and [AnimationController]
typedef ToastOverlayInfo = ({OverlayEntry entry, AnimationController slideAnimationController});

/// Position of the toast
enum ToastPosition {
  top,
  bottom,
}

/// Advanced [OverlayManager] for showing toasts or custom overlays.
@immutable
class OverlayManager {
  OverlayManager(this._key);

  /// [NavigatorState] key of desired [Navigator]
  final GlobalKey<NavigatorState> _key;

  /// Holds active overlays and controllers
  final _overlayInfoList = <ToastOverlayInfo>[];

  /// Default toast duration
  final _defaultToastDuration = const Duration(milliseconds: 2000);

  /// Default toast slide animation duration
  final _slideAnimationDuration = const Duration(milliseconds: 500);

  /// Shows a highly customizable toast with animation
  void showToast({
    Key? key,
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    int? messageMaxLines,
    ToastPosition toastPosition = ToastPosition.bottom,
    Color? backgroundColor,
    Color? shadowColor,
    DismissDirection? dismissDirection,
    Widget? leading,
    Duration? toastDuration,
    Duration? animationDuration,
    Duration? reverseAnimationDuration,
    Widget? child,
  }) {
    _presentToast(
      key: key,
      title: title,
      message: message,
      leading: leading,
      toastDuration: toastDuration,
      animationDuration: animationDuration,
      reverseAnimationDuration: reverseAnimationDuration,
      toastPosition: toastPosition,
      dismissDirection: dismissDirection,
      child: child,
      backgroundColor: backgroundColor,
      messageStyle: messageStyle,
      messageMaxLines: messageMaxLines,
      shadowColor: shadowColor,
      titleStyle: titleStyle,
    );
  }

  /// Inserts toast into overlay state entries list and schedules for removal after [toastDuration]
  ///
  /// This is the function actually shows the toast
  void _presentToast({
    required ToastPosition toastPosition,
    Key? key,
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Duration? toastDuration,
    Duration? animationDuration,
    Duration? reverseAnimationDuration,
    int? messageMaxLines,
    DismissDirection? dismissDirection,
    Widget? leading,
    Widget? child,
    Color? backgroundColor,
    Color? shadowColor,
  }) {
    final overlayState = _key.currentState?.overlay;
    assert(overlayState.isNotNull, 'Tried to show toast but overlayState was null. Key was :$_key');
    Dock.throwConditionalError(
      error: MisUsageToastError('If child is specified; leading, title and message must be null'),
      throwIf: child.isNotNull && (leading.isNotNull || title.isNotNull || message.isNotNull),
    );

    final slideAnimationController = AnimationController(
      vsync: overlayState!,
      duration: animationDuration ?? _slideAnimationDuration,
      reverseDuration: reverseAnimationDuration ?? _slideAnimationDuration,
    );
    late final OverlayEntry overlayEntry;
    var isPendingRemoval = true;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return DockToast(
          key: key,
          slideAnimationController: slideAnimationController,
          toastPosition: toastPosition,
          leading: leading,
          title: title,
          message: message,
          messageMaxLines: messageMaxLines,
          dismissDirection: dismissDirection,
          onDismissed: (direction) {
            if (isPendingRemoval) {
              isPendingRemoval = false;
              _overlayInfoList.remove((entry: overlayEntry, slideAnimationController: slideAnimationController));
              overlayEntry
                ..remove()
                ..dispose();
              slideAnimationController.dispose();
            }
          },
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          titleStyle: titleStyle,
          messageStyle: messageStyle,
          child: child,
        );
      },
    );

    _insertToast(slideAnimationController, overlayEntry, overlayState);
    _scheduleToastForRemoval(toastDuration ?? _defaultToastDuration, slideAnimationController, overlayEntry, overlayState);
  }

  /// Inserts toast into overlay entries and forwards the animation
  void _insertToast(AnimationController slideAnimationController, OverlayEntry entry, OverlayState overlayState) {
    final overlayInfo = (entry: entry, slideAnimationController: slideAnimationController);
    _overlayInfoList.insert(0, overlayInfo);
    overlayState.insert(entry);
    slideAnimationController.forward();
  }

  /// Reverses the animation after [schedule] and removes toast when animation is completed
  void _scheduleToastForRemoval(Duration schedule, AnimationController slideAnimationController, OverlayEntry entry, OverlayState overlayState) {
    schedule.delay(() {
      final elementIndex = _overlayInfoList.indexOf((entry: entry, slideAnimationController: slideAnimationController));
      final overlayInfo = _overlayInfoList[elementIndex];
      overlayInfo.slideAnimationController.reverse().then((_) {
        overlayInfo.entry
          ..remove()
          ..dispose();
        overlayInfo.slideAnimationController.dispose();
        _overlayInfoList.remove(overlayInfo);
      });
    });
  }

  /// THIS MAY BROKE EXISTING IMPLEMENTATION OF [OverlayManager]
  /// IF IT'S NEEDED, API SHOULD BE REFACTORED

//   /// Gets [OverlayManager] of nearest [Navigator].
//   ///
//   /// Returns null if can't find
//   static OverlayManager? maybeOf(BuildContext context) {
//     if (Navigator.of(context).overlay.isNull) return null;
//     Navigator.of(context).
//     return OverlayManager().._ovState = context.router.navigatorKey.currentState!.overlay;
//   }
//
//   /// Gets [OverlayManager] of nearest [Navigator].
//   static OverlayManager of(BuildContext context) {
//     assert(context.router.navigatorKey.currentState?.overlay != null, '''
//     Tried to get Overlay but found null''');
//     return OverlayManager().._ovState = context.router.navigatorKey.currentState!.overlay;
//   }
}

/// Error thrown when [OverlayManager] is misused
final class MisUsageToastError extends Error {
  MisUsageToastError(this.message);

  /// Explanation of the error
  final String message;

  @override
  String toString() {
    return 'MisUsageToastError: $message';
  }
}
