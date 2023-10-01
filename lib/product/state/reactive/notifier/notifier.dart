import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/listenable/dock_listenable.dart';
import 'package:liman/product/state/reactive/notifier/notify_data.dart';
import 'package:liman/product/state/reactive/observer/observer_error.dart';

typedef WidgetCallback = Widget Function();
typedef Disposer = void Function();

class Notifier {
  Notifier._();

  static Notifier? _instance;

  // ignore: prefer_constructors_over_static_methods
  static Notifier get instance => _instance ??= Notifier._();

  NotifyData? _notifyData;

  void addDisposer(Disposer disposer) {
    _notifyData?.disposers.add(disposer);
  }

  void notifyRead(DockListenable listenable) {
    final updater = _notifyData?.updater;
    if (updater != null && !listenable.containsUpdater(updater: updater)) {
      listenable.addUpdater(updater);
      void disposer() {
        listenable.removeUpdater(updater);
      }

      addDisposer(disposer);
    }
  }

  Widget createElement(NotifyData data, WidgetCallback builder) {
    _notifyData = data;
    final result = builder();
    if (data.disposers.isEmpty) {
      throw const ObserverError();
    }
    _notifyData = null;
    return result;
  }
}
