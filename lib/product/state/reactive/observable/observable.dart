import 'package:liman/product/state/reactive/listener/dock_listenable.dart';
import 'package:liman/product/state/reactive/notifier/notifier.dart';

class Observable<T> extends DockListenable {
  Observable(this._value);

  T _value;
  bool _firstBuild = true;

  T get value {
    Notifier.instance.read(this);
    return _value;
  }

  void changeValue(T newValue) {
    //TODO Check this for iterables etc..
    if (newValue == _value) return;
    _value = newValue;
    update();
  }
}
