part of '../observable/observable.dart';

typedef WidgetCallback = Widget Function();
typedef Disposer = void Function();

final class Notifier {
  Notifier._();

  static Notifier? _instance;

  // ignore: prefer_constructors_over_static_methods
  static Notifier get instance => _instance ??= Notifier._();

  NotifyData? _notifyData;

  void addDisposer(Disposer disposer) {
    _notifyData?.disposers.add(disposer);
  }

  void notifyRead<T>(Observable<T> observable) {
    final updater = _notifyData?.updater;
    if (updater != null && !observable._containsUpdater(updater: updater)) {
      observable._addUpdater(updater);
      void disposer() {
        observable._removeUpdater(updater);
      }

      addDisposer(disposer);
    }
  }

  Widget createObserver(NotifyData data, WidgetCallback builder) {
    _notifyData = data;
    final result = builder();
    if (data.disposers.isEmpty) {
      throw const ObserverError();
    }
    _notifyData = null;
    return result;
  }
}
