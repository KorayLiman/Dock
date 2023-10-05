import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liman/product/state/reactive/notifier/notify_data.dart';
import 'package:liman/product/state/reactive/observable/observable.dart';

typedef Disposer = void Function();

mixin ObserverStatelessElementMixin on StatelessElement {
  List<Disposer>? _disposers;

  @override
  void mount(Element? parent, Object? newSlot) {
    _disposers = [];
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    for (final disposer in _disposers!) {
      disposer.call();
    }
    _disposers!.clear();
    _disposers = null;
    super.unmount();
  }

  void updateElement() {
    if (_disposers != null) {
      final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
      if (schedulerPhase == SchedulerPhase.idle || schedulerPhase == SchedulerPhase.postFrameCallbacks) {
        markNeedsBuild();
      } else {
        scheduleMicrotask(markNeedsBuild);
      }
    }
  }

  @override
  Widget build() {
    return Notifier.instance.createElement(
      NotifyData(updater: updateElement, disposers: _disposers!),
      super.build,
    );
  }
}
