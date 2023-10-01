import 'package:flutter/material.dart';

typedef Updater = void Function();

class DockListenable extends Listenable {
  List<Updater>? _updaters = [];

  @override
  void addListener(Updater listener) {
    _assertObserverNotDisposed();
    _updaters!.add(listener);
  }

  @override
  void removeListener(Updater listener) {
    _assertObserverNotDisposed();
    _updaters!.remove(listener);
    if (_updaters!.isEmpty) {
      _updaters = null;
    }
  }

  void addUpdater(Updater updater) {
    addListener(updater);
  }

  void removeUpdater(Updater updater) {
    removeListener(updater);
  }

  bool containsUpdater({required Updater updater}) {
    return _updaters?.contains(updater) ?? false;
  }

  @protected
  void notifyToUpdate() {
    _assertObserverNotDisposed();
    for (final updater in _updaters!) {
      updater.call();
    }
  }

  bool get isObserverDisposed => _updaters == null;

  void _assertObserverNotDisposed() {
    assert(!isObserverDisposed, 'An $runtimeType was used after Observers contain $runtimeType already disposed');
  }
}
