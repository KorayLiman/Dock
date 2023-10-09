import 'package:flutter/material.dart';
import 'package:dock/product/state/reactive/notifier/notify_data.dart';
import 'package:dock/product/state/reactive/observer/observer_error.dart';

part '../notifier/notifier.dart';

typedef ChangeGenericValue<T> = T Function(T object);
typedef Updater = void Function();

final class Observable<T> {
  Observable(this._value);

  List<Updater>? _updaters = [];

  void _addUpdater(Updater updater) {
    _assertObserverNotDisposed();
    _updaters!.add(updater);
  }

  void _removeUpdater(Updater updater) {
    _assertObserverNotDisposed();
    _updaters!.remove(updater);
    if (_updaters!.isEmpty) {
      _updaters = null;
    }
  }

  bool _containsUpdater({required Updater updater}) {
    return _updaters?.contains(updater) ?? false;
  }

  @protected
  void _notifyToUpdate() {
    _assertObserverNotDisposed();
    for (final updater in _updaters!) {
      updater.call();
    }
  }

  bool get isObserverDisposed => _updaters == null;

  void _assertObserverNotDisposed() {
    assert(!isObserverDisposed, 'An $runtimeType was used after Observers contain $runtimeType already disposed');
  }

  T _value;

  T get value {
    Notifier.instance.notifyRead<T>(this);
    return _value;
  }

  set value(T newValue) {
    // TODO(KorayLiman): handle complex comparisons
    if (newValue == _value) return;
    _value = newValue;
    _notifyToUpdate();
  }

  void update(ChangeGenericValue<T> changeGenericValue) {
    value = changeGenericValue.call(value);
  }
}
