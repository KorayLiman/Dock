import 'package:flutter/material.dart';

class DockListenable extends Listenable {
  List<VoidCallback>? _listeners = [];

  @override
  void addListener(VoidCallback listener) {
    _debugAssertNotDisposed();
    _listeners!.add(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    _debugAssertNotDisposed();
    _listeners!.remove(listener);
  }

  bool containsListener({required VoidCallback listener}) {
    return _listeners?.contains(listener) ?? false;
  }

  @protected
  void update() {
    _debugAssertNotDisposed();
    _notifyToUpdate();
  }

  void _notifyToUpdate() {
    for (final listener in _listeners!) {
      listener.call();
    }
  }

  void onDispose() {
    _listeners?.clear();
    _listeners = null;
  }

  bool get isDisposed => _listeners == null;

  bool _debugAssertNotDisposed() {
    assert(
      () {
        if (isDisposed) {
          throw FlutterError('''
        A $runtimeType was used after being disposed.\n
'Once you have called dispose() on a $runtimeType, it can no longer be used.''');
        }
        return true;
      }(),
      'A $runtimeType already disposed',
    );
    return true;
  }
}
