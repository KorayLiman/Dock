part of '../observable/observable.dart';

/// Simply a bridge between [Observable] and ObserverStatelessElement (or call it Observer)
///
/// When an Observer is building if any [Observable] is encountered calls [notifyRead]
///
/// Adds [Updater] to Observable and [Disposer] to ObserverStatelessElement
final class Notifier {
  Notifier._();

  static Notifier? _instance;

  // ignore: prefer_constructors_over_static_methods
  static Notifier get instance => _instance ??= Notifier._();

  NotifyData? _notifyData;

  /// Adds [Disposer] to _disposers list inside ObserverStatelessElement
  void addDisposer(Disposer disposer) {
    _notifyData?.disposers.add(disposer);
  }

  /// Adds [Updater] to [Observable] and [Disposer] to ObserverStatelessElement
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

  /// Parses Observer for any [Observable]s inside
  Widget createObserver(NotifyData data, WidgetCallback builder) {
    _notifyData = data;
    final result = builder();
    if (data.disposers.isEmpty) {
      throw ObserverError();
    }
    _notifyData = null;
    return result;
  }
}
