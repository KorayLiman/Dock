import 'package:liman/core/base/dock_base/dock_base.dart';

typedef FrameCallback = void Function(Duration timeStamp);

/// GLOBAL INSTANCE OF _DOCK CLASS
// ignore: non_constant_identifier_names
final Dock = _Dock();

/// CHILD CLASS OF DOCKBASE
final class _Dock extends DockBase {
  /// Cause the entire application to redraw
  ///
  /// Until it's done Touch, Pointer events won't work
  ///
  /// Use it with caution
  Future<void> reassembleApplication() async {
    await widgetsBinding.reassembleApplication();
  }

  /// Schedule a callback for the end of this frame
  void registerPostFrameCallback(FrameCallback callBack) {
    widgetsBinding.addPostFrameCallback(callBack);
  }

  /// Schedule a callback for the beginning of next frame
  ///
  /// Returns it's id for cancellation
  int registerNextFrameCallback(FrameCallback callBack) {
    return widgetsBinding.scheduleFrameCallback(callBack);
  }
}
