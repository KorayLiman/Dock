import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// A [DialogRoute] shows [CircularProgressIndicator] in center
final class LoaderRoute extends DialogRoute<dynamic> {
  @visibleForTesting
  LoaderRoute({
    required super.context,
    required super.builder,
    this.id,
    super.barrierDismissible,
  });

  final Object? id;
}

/// Helper class for showing popups
///
/// [NavigatorState] key is required either of Root's or Nested Navigator's
@immutable
class PopupManager {
  PopupManager(this._key);

  final GlobalKey<NavigatorState> _key;
  final _routes = <LoaderRoute>[];

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  void showLoader({Object? id, bool barrierDismissible = false, WidgetBuilder? loaderBuilder}) {
    assert(_key.currentState.isNotNull, 'Tried to show dialog but navigatorState was null. Key was :$_key');
    final navigatorState = _key.currentState!;
    assert(
      id.isNull || _routes.where((element) => element.id == id).toList().isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: navigatorState.context,
      builder: loaderBuilder ??
          (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
    );

    _routes.add(route);
    navigatorState.push(route);
  }

  /// If [id] is provided closes loader with given [id]
  /// If not closes latest shown loader
  void hideLoader({Object? id}) {
    assert(
      id.isNull || _routes.where((element) => element.id == id).toList().isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(_key.currentState.isNotNull, 'Tried to hide dialog but navigatorState was null. Key was :$_key');
    final navigatorState = _key.currentState!;
    if (id.isNull) {
      navigatorState.removeRoute(_routes.removeLast());
    } else {
      final routeIndex = _routes.indexWhere((element) => element.id == id);
      navigatorState.removeRoute(_routes.removeAt(routeIndex));
    }
  }
}
