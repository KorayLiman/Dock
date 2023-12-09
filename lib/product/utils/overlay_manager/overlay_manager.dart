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

  // double _getHorizontalPosition(Size size) => size.width * 0.12;
  //
  // double _getVerticalPosition(Size size) => size.width * 0.1;
  //
  // final _defaultToastColor = Colors.grey.shade500;
  // final _toastRadius = 16.0;
  // final _overlayDuration = 2.seconds;
  // final _defaultFadeInDuration = 400.milliseconds;
  // final _defaultFadeInDelay = 25.milliseconds;
  final _defaultAnimDuration = 500.milliseconds;

  /// Shows simple Toast with given [message]
  void showToast(String message) {
    // assert(_key.currentState?.overlay != null, 'Tried to show toast but overlayState was null. Key was :$_key');
    // assert(_defaultFadeInDuration + _defaultFadeInDelay <= _overlayDuration, '''
    // _defaultFadeInDelay + _defaultFadeDuration must be less than or equal to _overlayDuration''');
    // final currentOpacity = 0.observable;
    // Positioned widgetBuilder(BuildContext context) {
    //   final size = context.mediaQuerySize;
    //   return Positioned(
    //     top: toastPosition == ToastPosition.top ? context.mediaQueryViewPadding.top + _getVerticalPosition(size) : null,
    //     bottom: toastPosition == ToastPosition.bottom ? context.mediaQueryViewPadding.bottom + _getVerticalPosition(size) : null,
    //     left: _getHorizontalPosition(size),
    //     right: _getHorizontalPosition(size),
    //     child: Observer(
    //       builder: (context) {
    //         return AnimatedOpacity(
    //           opacity: currentOpacity.value.toDouble(),
    //           duration: _defaultFadeInDuration,
    //           child: Material(
    //             color: _defaultToastColor,
    //             borderRadius: BorderRadius.circular(_toastRadius),
    //             child: Center(
    //               child: Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    //                 child: Text(
    //                   message,
    //                   style: const TextStyle(color: Colors.white),
    //                   textAlign: TextAlign.center,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
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
    _overlayRecordList.add((entry: entry, controller: controller));
    overlayState.insert(entry);
    controller.forward();
  }

  void _reverseAndRemove(OverlayState overlayState) {
    final overlayRecord = _overlayRecordList.first;
    overlayRecord.controller.reverse().then((_) {
      overlayRecord.controller.dispose();
      overlayRecord.entry.remove();
      overlayRecord.entry.dispose();
    });
    _overlayRecordList.remove(overlayRecord);
    // controller.reverse().then((value) {

    // final index = _activeAnimationControllers.indexOf(controller);
    // _activeAnimationControllers.removeAt(index);
    // _activeOverlays.remove(index);
    // overlayEntry
    //   ..remove()
    //   ..dispose();
    // });
  }

  void _presentOverlay() {
    final overlayState = _key.currentState?.overlay;
    assert(overlayState.isNotNull, 'Tried to show toast but overlayState was null. Key was :$_key');

    final overlayEntryAnimController = AnimationController(
      vsync: overlayState!,
      duration: _defaultAnimDuration,
      reverseDuration: _defaultAnimDuration,
    );
    final overlayEntry = OverlayEntry(builder: (context) {
      return const SizedBox();
    });
    _insertAndForward(overlayEntryAnimController, overlayEntry, overlayState);
    2.seconds.delay(() {
      _reverseAndRemove(overlayState);
    });
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
