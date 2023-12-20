import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

typedef PositionedBuilder = Positioned Function(BuildContext context);
typedef ToastPosition = ({double bottom, double left, double right});
typedef ToastOverlayInfo = ({OverlayEntry entry, AnimationController controller});

/// Advanced [OverlayManager] for showing toasts or custom overlays.
@immutable
class OverlayManager {
  OverlayManager(this._key);

  /// [NavigatorState] key of desired [Navigator]
  final GlobalKey<NavigatorState> _key;

  /// Holds active overlays and controllers
  final _overlayInfoList = <ToastOverlayInfo>[];

  /// Max stackable toast count
  final _maxStackCount = 3;

  /// Gap between stacked toasts
  final _gapBetween = 12.0;

  /// Reduced horizontal margin step of stacked toast below
  final _reducedHorizontalMarginStep = 8.0;

  /// Default toast bottom margin
  final _defaultToastBottomMargin = 40.0;

  /// Default toast horizontal margin
  final _defaultHorizontalMargin = 10.0;

  /// Default toast duration
  final _defaultToastDuration = const Duration(milliseconds: 2000);

  /// Shows a highly customizable toast with animation
  void showToast({
    Key? key,
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Color? backgroundColor,
    Color? shadowColor,
    Widget? leading,
    Duration? toastDuration,
    Widget? child,
  }) {
    _presentToast(
      key: key,
      title: title,
      message: message,
      leading: leading,
      toastDuration: toastDuration,
      child: child,
      backgroundColor: backgroundColor,
      messageStyle: messageStyle,
      shadowColor: shadowColor,
      titleStyle: titleStyle,
    );
  }

  /// Shows custom [Overlay] with given [Widget]
  void showOverlay({required PositionedBuilder positionedBuilder}) {
    // assert(_key.currentState?.overlay != null, 'Tried to show overlay but overlayState was null. Key was :$_key');
    // assert(_defaultFadeInDuration + _defaultFadeInDelay <= _overlayDuration, '''
    // _defaultFadeInDelay + _defaultFadeDuration must be less than or equal to _overlayDuration''');
    // final currentOpacity = 0.observable;
    //
    // Positioned widgetBuilder(BuildContext context) {
    //   final pos = positionedBuilder(context);
    //   return Positioned(
    //     height: pos.height,
    //     width: pos.width,
    //     top: pos.top,
    //     bottom: pos.bottom,
    //     left: pos.left,
    //     right: pos.right,
    //     child: Observer(
    //       builder: (context) => AnimatedOpacity(
    //         opacity: currentOpacity.value.toDouble(),
    //         duration: _defaultFadeInDuration,
    //         child: Material(
    //           child: pos.child,
    //         ),
    //       ),
    //     ),
    //   );
    // }
    //
    // final overlayEntry = OverlayEntry(builder: widgetBuilder);
    // _key.currentState!.overlay!.insert(overlayEntry);
    // _defaultFadeInDelay.delay(() {
    //   currentOpacity.value = 1;
    // });
    // _overlayDuration.delay(() {
    //   overlayEntry
    //     ..remove()
    //     ..dispose();
    // });
  }

  /// Inserts toast into overlay state entries list and schedules for removal after [toastDuration]
  ///
  /// This is the function actually shows the toast
  void _presentToast({
    Key? key,
    String? title,
    String? message,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    Duration? toastDuration,
    Widget? leading,
    Widget? child,
    Color? backgroundColor,
    Color? shadowColor,
  }) {
    final overlayState = _key.currentState?.overlay;
    assert(overlayState.isNotNull, 'Tried to show toast but overlayState was null. Key was :$_key');

    final overlayEntryAnimController = AnimationController(
      vsync: overlayState!,
      duration: 500.milliseconds,
      reverseDuration: 500.milliseconds,
    );
    late final OverlayEntry? overlayEntry;
    var isPendingRemoval = true;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return DockToast(
          key: key,
          controller: overlayEntryAnimController,
          position: _getToastPosition(overlayEntry, overlayEntryAnimController),
          leading: leading,
          title: title,
          message: message,
          onDismissed: (direction) {
            if (isPendingRemoval) {
              isPendingRemoval = false;
              _overlayInfoList.remove((entry: overlayEntry!, controller: overlayEntryAnimController));
              overlayEntry
                ..remove()
                ..dispose();
              overlayEntryAnimController.dispose();
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

    _insertToast(overlayEntryAnimController, overlayEntry, overlayState);
    _scheduleToastForRemoval(toastDuration ?? _defaultToastDuration, overlayEntryAnimController, overlayEntry, overlayState);
  }

  /// Inserts toast into overlay entries and forwards the animation
  void _insertToast(AnimationController controller, OverlayEntry entry, OverlayState overlayState) {
    final overlayInfo = (entry: entry, controller: controller);
    _overlayInfoList.insert(0, overlayInfo);
    overlayState.insert(entry);
    controller.forward();
  }

  /// Reverses the animation after [schedule] and removes toast when animation is completed
  void _scheduleToastForRemoval(Duration schedule, AnimationController controller, OverlayEntry entry, OverlayState overlayState) {
    schedule.delay(() {
      final elementIndex = _overlayInfoList.indexOf((entry: entry, controller: controller));
      final overlayInfo = _overlayInfoList[elementIndex];
      overlayInfo.controller.reverse().then((_) {
        overlayInfo.entry.remove();
        overlayInfo.entry.dispose();
        overlayInfo.controller.dispose();
        _overlayInfoList.remove(overlayInfo);
      });
    });
  }

  /// A function that returns a Dart [Record] that calculates position of the toast
  ToastPosition _getToastPosition(OverlayEntry? overlayEntry, AnimationController controller) {
    final overlayIndex = _overlayInfoList.indexOf((entry: overlayEntry!, controller: controller));
    final bottomPosition = overlayIndex > (_maxStackCount - 1) ? _gapBetween * (_maxStackCount - 1) + _defaultToastBottomMargin : _gapBetween * overlayIndex + _defaultToastBottomMargin;
    final horizontalPosition = overlayIndex > (_maxStackCount - 1) ? _reducedHorizontalMarginStep * (_maxStackCount - 1) + _defaultHorizontalMargin : _reducedHorizontalMarginStep * overlayIndex + _defaultHorizontalMargin;
    return (bottom: bottomPosition, left: horizontalPosition, right: horizontalPosition);
  }

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
