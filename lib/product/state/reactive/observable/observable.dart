import 'package:dock_flutter/product/state/reactive/notifier/notify_data.dart';
import 'package:dock_flutter/product/state/reactive/observer/observer_error.dart';
import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

part '../notifier/notifier.dart';

final class Observable<T> {
  Observable(this._value);

  List<Updater>? _updaters = [];

  /// Adds [Updater] function to the list [_updaters]
  void _addUpdater(Updater updater) {
    _assertObserverNotDisposed();
    _updaters!.add(updater);
  }

  /// Removes [Updater] function from the list [_updaters]
  void _removeUpdater(Updater updater) {
    _assertObserverNotDisposed();
    _updaters!.remove(updater);
    if (_updaters!.isEmpty) {
      _updaters = null;
    }
  }

  /// Checks if given [updater] exists in [_updaters]
  bool _containsUpdater({required Updater updater}) {
    return _updaters?.contains(updater) ?? false;
  }

  /// This is called when observable's value changes to update
  /// related Observer
  ///
  /// eg. counter.value++;
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

  /// Value of [Observable]
  T _value;

  /// Getter of [_value]
  T get value {
    Notifier.instance.notifyRead<T>(this);
    return _value;
  }

  /// Setter of [_value]
  set value(T newValue) {
    // TODO(KorayLiman): handle complex comparisons
    if (newValue == _value) return;
    _value = newValue;
    _notifyToUpdate();
  }

  /// Updates [Observable] after provided callback ends.
  ///
  /// Useful when dealing with Observable Collections or enums etc.
  void update(ChangeGenericValue<T> changeGenericValue) {
    changeGenericValue.call(value);
    _notifyToUpdate();
  }
}
