import 'package:dock_flutter/typedefs.dart';

/// Data passed between Observable and Observer
///
/// Updater is void Function that rebuilds widget
///
/// Disposer is void Function that removes single updater in Observer
final class NotifyData {
  const NotifyData({required this.updater, required this.disposers});

  final Updater updater;
  final List<Disposer> disposers;
}
