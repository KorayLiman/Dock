import 'package:dock_flutter/core/base/dock_base/dock_base.dart';
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
  void registerPostFrameCallback(FrameCallback callBack) {
    widgetsBinding.addPostFrameCallback(callBack);
  }

  /// Schedule a callback for the beginning of next frame
  ///
  /// Returns it's id for cancellation
  int registerNextFrameCallback(FrameCallback callBack) {
    return widgetsBinding.scheduleFrameCallback(callBack);
  }

  /// Cancels registered [FrameCallback] with given [id]
  void cancelRegisteredFrameCallback(int id) {
    return widgetsBinding.cancelFrameCallbackWithId(id);
  }

  /// Throws [exception] if given condition [throwIf] is satisfied
  void throwConditional({required Exception exception, required bool throwIf}) {
    if (throwIf) throw exception;
  }

  /// Checks if the current phase of the scheduler is safe
  ///
  /// Means that if the scheduler is idle or in post frame callbacks
  /// it's safe to rebuild widgets
  ///
  /// This is a precaution to "setState() or markNeedsBuild() called during build" error
  bool get isInSafeSchedulerPhase {
    final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
    return schedulerPhase == SchedulerPhase.idle || schedulerPhase == SchedulerPhase.postFrameCallbacks;
  }

  /// Waits until the end of the current frame
  Future<void> waitUntilEndOfFrame() async {
    if (isInSafeSchedulerPhase) return;
    await SchedulerBinding.instance.endOfFrame;
  }

  /// Marks given [element] as needing to build in the next frame
  /// without throwing "setState() or markNeedsBuild() called during build" error
  ///
  /// Checks also if the [element] is mounted
  Future<void> safeMarkNeedsBuild(Element element) async {
    await waitUntilEndOfFrame();
    if (element.mounted) element.markNeedsBuild();
  }
}
