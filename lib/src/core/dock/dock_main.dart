import 'package:dock_flutter/src/core/base/dock_base/dock_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  void addPostFrameCallback(FrameCallback callback) {
    widgetsBinding.addPostFrameCallback(callback);
  }

  /// Schedule a callback for the end of this frame
  /// 
  /// If the current phase is [SchedulerPhase.postFrameCallbacks], it will call the callback immediately
  /// and since we didn't track render time, it doesn't seem possible to know timeStamp
  void addPostFrameCallbackRaw(VoidCallback callback) {
    if (schedulerBinding.schedulerPhase == SchedulerPhase.postFrameCallbacks) {
      callback();
    } else {
      widgetsBinding.addPostFrameCallback((timeStamp) {
        callback();
      });
    }
  }

  /// Schedule a callback for the beginning of next frame
  ///
  /// Returns it's id for cancellation
  int scheduleFrameCallback(FrameCallback callback) {
    return widgetsBinding.scheduleFrameCallback(callback);
  }

  /// Cancels scheduled [FrameCallback] with given [id]
  void cancelScheduledFrameCallback(int id) {
    return widgetsBinding.cancelFrameCallbackWithId(id);
  }

  /// Throws [exception] if given condition [throwIf] is satisfied
  void throwConditionalException(
      {required Exception exception, required bool throwIf}) {
    if (throwIf) throw exception;
  }

  /// Throws [error] if given condition [throwIf] is satisfied
  void throwConditionalError({required Error error, required bool throwIf}) {
    if (throwIf) throw error;
  }

  // TODO(KorayLiman): Naming and documentation of this method is WRONG!!! and probably not needed. Should be removed.

  /// Checks if the current phase of the scheduler is safe
  ///
  /// Means that if the scheduler is idle or in post frame callbacks
  /// it's safe to rebuild widgets
  ///
  /// This is a precaution to "setState() or markNeedsBuild() called during build" error
  // bool get _isInSafeSchedulerPhase {
  // final schedulerPhase = schedulerBinding.schedulerPhase;
  //return schedulerPhase == SchedulerPhase.idle ||
  //  schedulerPhase == SchedulerPhase.postFrameCallbacks;
  // }

  // TODO(KorayLiman): Remove this method not needed.

  /// This is a bit of problem because skips one extra frame which is not we want
  // /// Waits until the end of the current frame
  // Future<void> _waitUntilEndOfFrame() async {
  //   if (_isInSafeSchedulerPhase) return;
  //   await SchedulerBinding.instance.endOfFrame;
  // }

  /// Marks given [element] as needing to build in the next frame
  /// without throwing "setState() or markNeedsBuild() called during build" error
  ///
  /// If we are in idle or post frame callbacks phase, markNeedsBuild() will schedule a frame for rebuild
  /// If not, it will schedule a frame for rebuild after the current frame
  ///
  /// Checks also if the [element] is mounted
  void safeMarkNeedsBuild(Element element) {
    final schedulerPhase = schedulerBinding.schedulerPhase;
    if (schedulerPhase == SchedulerPhase.idle ||
        schedulerPhase == SchedulerPhase.postFrameCallbacks) {
      if (element.mounted) element.markNeedsBuild();
    } else {
      addPostFrameCallback((timeStamp) {
        if (element.mounted) element.markNeedsBuild();
      });
    }
  }
}
