typedef Disposer = void Function();
typedef Updater = void Function();

final class NotifyData {
  const NotifyData({required this.updater, required this.disposers});

  final Updater updater;
  final List<Disposer> disposers;
}
