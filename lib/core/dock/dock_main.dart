import 'package:dock_flutter/core/base/dock_base/dock_base.dart';
import 'package:dock_flutter/typedefs.dart';

/// GLOBAL INSTANCE OF [_Dock] CLASS
// ignore: non_constant_identifier_names
final Dock = _Dock();

/// CHILD CLASS OF [DockBase]
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

  /// Throws [exception] if given condition [throwIf] is satisfied
  void throwConditional({required Exception exception, required bool throwIf}) {
    if (throwIf) throw exception;
  }
}
