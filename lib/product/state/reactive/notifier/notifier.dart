import 'package:flutter/material.dart';
import 'package:liman/product/state/reactive/listener/dock_listenable.dart';

class Notifier {
  Notifier._();

  static Notifier? _instance;

  static Notifier get instance => _instance ??= Notifier._();

  NotifyData? _notifyData;

  void add(VoidCallback listener) {
    _notifyData?.disposers.add(listener);
  }

  void read(DockListenable listenable) {
    final listener = _notifyData?.updater;
    if (listener != null && !listenable.containsListener(listener: listener)) {
      listenable.addListener(listener);
      add(() => listenable.removeListener(listener));
    }
  }

  T append<T>(NotifyData data, T Function() builder) {
    _notifyData = data;
    final result = builder();
    if (data.disposers.isEmpty && data.throwException) {
      throw const ObserverError();
    }
    _notifyData = null;
    return result;
  }
}

class NotifyData {
  const NotifyData({required this.updater, required this.disposers, this.throwException = true});

  final VoidCallback updater;
  final List<VoidCallback> disposers;
  final bool throwException;
}

class ObserverError implements Exception {
  const ObserverError();
  @override
  String toString() {
    return '''
      You did not insert any observables in Observer
      ''';
  }
}
