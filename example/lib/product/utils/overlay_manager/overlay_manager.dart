import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:flutter/material.dart';

typedef PositionedBuilder = Positioned Function(BuildContext context);

/// Simple [OverlayManager] for showing overlays(toasts or custom overlays).
final class OverlayManager {
  OverlayManager();

  OverlayState? _ovState;

  OverlayState? get overlayState => _ovState.isNull ? Locator.tryFind<AppRouter>()?.root.navigatorKey.currentState?.overlay : _ovState;

  double _getHorizontalPosition(Size size) => size.width * 0.12;

  double _getVerticalPosition(Size size) => size.width * 0.1;

  final _defaultToastColor = Colors.grey.shade500;
  final _toastRadius = 16.0;
  final _overlayDuration = 2.seconds;
  final _defaultFadeDuration = 400.milliseconds;
  final _defaultFadeInDelay = 25.milliseconds;

  /// Shows simple [Toast] with given [message]
  void showToast(String message, {ToastPosition toastPosition = ToastPosition.bottom}) {
    assert(_defaultFadeDuration + _defaultFadeInDelay <= _overlayDuration, '''
    _defaultFadeInDelay + _defaultFadeDuration must be less than or equal to _overlayDuration''');
    final currentOpacity = 0.observable;
    final widgetBuilder = (BuildContext context) {
      final size = context.mediaQuerySize;
      return Positioned(
        top: toastPosition == ToastPosition.top ? _getVerticalPosition(size) : null,
        bottom: toastPosition == ToastPosition.bottom ? _getVerticalPosition(size) : null,
        left: _getHorizontalPosition(size),
        right: _getHorizontalPosition(size),
        child: Observer(builder: (context) {
          return AnimatedOpacity(
            opacity: currentOpacity.value.toDouble(),
            duration: _defaultFadeDuration,
            child: Material(
              color: _defaultToastColor,
              borderRadius: BorderRadius.circular(_toastRadius),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }),
      );
    };

    final overlayEntry = OverlayEntry(builder: widgetBuilder);
    overlayState?.insert(overlayEntry);
    _defaultFadeInDelay.delay(() {
      currentOpacity.value = 1;
    });
    _overlayDuration.delay(() {
      overlayEntry.remove();
      overlayEntry.dispose();
    });
  }

  /// Shows custom [Overlay] with given [Widget]
  void showCustomOverlay({required PositionedBuilder positionedBuilder}) {
    final currentOpacity = 0.observable;

    final widgetBuilder = (BuildContext context) {
      final pos = positionedBuilder(context);
      return Positioned(
        height: pos.height,
        width: pos.width,
        top: pos.top,
        bottom: pos.bottom,
        left: pos.left,
        right: pos.right,
        child: Observer(
          builder: (context) => AnimatedOpacity(
            opacity: currentOpacity.value.toDouble(),
            duration: _defaultFadeDuration,
            child: Material(
              child: pos.child,
            ),
          ),
        ),
      );
    };
    final overlayEntry = OverlayEntry(builder: widgetBuilder);
    overlayState?.insert(overlayEntry);
    _defaultFadeInDelay.delay(() {
      currentOpacity.value = 1;
    });
    _overlayDuration.delay(() {
      overlayEntry.remove();
      overlayEntry.dispose();
    });
  }

  /// Gets [OverlayManager] of nearest [Router].
  ///
  /// Returns null if can't find
  static OverlayManager? maybeOf(BuildContext context) {
    if (context.router.navigatorKey.currentState?.overlay == null) return null;
    return OverlayManager().._ovState = context.router.navigatorKey.currentState!.overlay;
  }

  /// Gets [OverlayManager] of nearest [Router].
  static OverlayManager of(BuildContext context) {
    assert(context.router.navigatorKey.currentState?.overlay != null, '''
    Tried to get Overlay but found null''');
    return OverlayManager().._ovState = context.router.navigatorKey.currentState!.overlay;
  }
}

/// Screen position of [Toast]
enum ToastPosition {
  top,
  bottom,
}
