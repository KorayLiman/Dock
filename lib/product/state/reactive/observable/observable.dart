import 'package:liman/product/state/reactive/listenable/dock_listenable.dart';
import 'package:liman/product/state/reactive/notifier/notifier.dart';

typedef ChangeGenericValue<T> = T Function(T object);

class Observable<T> extends DockListenable {
  Observable(this._value);

  T _value;

  T get value {
    Notifier.instance.notifyRead(this);
    return _value;
  }

  set value(T newValue) {
    // TODO handle complex comparisons
    if (newValue == _value) return;
    _value = newValue;
    notifyToUpdate();
  }

  void update(ChangeGenericValue<T> changeGenericValue) {
    value = changeGenericValue.call(value);
  }
}
