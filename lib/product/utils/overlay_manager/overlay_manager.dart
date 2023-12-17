import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

typedef PositionedBuilder = Positioned Function(BuildContext context);

/// Advanced [OverlayManager] for showing toasts or custom overlays.
final class OverlayManager {
  OverlayManager(this._key);

  /// [NavigatorState] key of desired [Navigator]
  final GlobalKey<NavigatorState> _key;

  /// Holds active overlays and controllers
  static final _overlayRecordList = <({OverlayEntry entry, AnimationController controller})>[];

  /// Max stackable toast count
  static const double _maxStackCount = 3;

  /// Gap between stacked toasts
  static const double _gapBetween = 12;

  /// Reduced horizontal margin step of stacked below toast
  static const double _reducedHorizontalMarginStep = 8;

  /// Default toast bottom margin
  static const double _defaultToastBottomMargin = 40;

  /// Default toast horizontal margin
  static const double _defaultHorizontalMargin = 10;

  void showToast({Key? key, String? title, String? message, Widget? leading}) {
    _presentOverlay(key: key, title: title, message: message, leading: leading);
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

  void _insertAndForward(AnimationController controller, OverlayEntry entry, OverlayState overlayState) {
    final record = (entry: entry, controller: controller);
    _overlayRecordList.insert(0, record);
    overlayState.insert(entry);
    controller.forward();
  }

  void _reverseAndRemove(AnimationController controller, OverlayEntry entry, OverlayState overlayState) {
    final elementIndex = _overlayRecordList.indexOf((entry: entry, controller: controller));
    final overlayRecord = _overlayRecordList[elementIndex];
    overlayRecord.controller.reverse().then((_) {
      overlayRecord.entry.remove();
      overlayRecord.entry.dispose();
      overlayRecord.controller.dispose();
      _overlayRecordList.removeLast();
    });
  }

  void _presentOverlay({Key? key, String? title, Widget? leading, String? message}) {
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
          controller: overlayEntryAnimController,
          position: _getToastPosition(overlayEntry, overlayEntryAnimController),
          leading: leading,
          title: title,
          message: message,
          onDismissed: (direction) {
            if (isPendingRemoval) {
              isPendingRemoval = false;
              _overlayRecordList.remove((entry: overlayEntry!, controller: overlayEntryAnimController));
              overlayEntry
                ..remove()
                ..dispose();
              overlayEntryAnimController.dispose();
            }
          },
        );
      },
    );

    _insertAndForward(overlayEntryAnimController, overlayEntry, overlayState);
    2.seconds.delay(() {
      if (isPendingRemoval) {
        _reverseAndRemove(overlayEntryAnimController, overlayEntry!, overlayState);
      }
    });
  }

  ({double bottom, double left, double right}) _getToastPosition(OverlayEntry? overlayEntry, AnimationController controller) {
    final overlayIndex = _overlayRecordList.indexOf((entry: overlayEntry!, controller: controller));

    final bottomPosition = overlayIndex > (_maxStackCount - 1) ? _gapBetween * (_maxStackCount - 1) + _defaultToastBottomMargin : _gapBetween * overlayIndex + _defaultToastBottomMargin;
    final horizontalPosition = overlayIndex > (_maxStackCount - 1) ? _reducedHorizontalMarginStep * (_maxStackCount - 1) + _defaultHorizontalMargin : _reducedHorizontalMarginStep * overlayIndex + _defaultHorizontalMargin;
    print(bottomPosition);
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
