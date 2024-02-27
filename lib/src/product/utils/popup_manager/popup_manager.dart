import 'dart:collection';

import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// Helper class for showing popups
///
/// [NavigatorState] key is required either of Root's or Nested Navigator's
@immutable
class PopupManager {
  PopupManager(this._key, {this.widgetBuilder});

  /// Desired [NavigatorState] key
  final GlobalKey<NavigatorState> _key;

  /// [WidgetBuilder] for loader
  final WidgetBuilder? widgetBuilder;

  /// List of [_LoaderRoute]s
  final _routes = <_LoaderRoute>[];

  /// Unmodifiable list of [_LoaderRoute]s for testing
  @visibleForTesting
  UnmodifiableListView<_LoaderRoute> get routes => UnmodifiableListView<_LoaderRoute>(_routes);

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  void showLoader({Object? id, bool barrierDismissible = false}) {
    assert(_key.currentState.isNotNull, 'Tried to show dialog but navigatorState was null. Key was :$_key');

    assert(
      id.isNull || _routes.where((element) => element.id == id).isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = _LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: _key.currentState!.context,
      builder: widgetBuilder ??
          (BuildContext context) => const Center(
                child: CircularProgressIndicator(),
              ),
    );

    _routes.add(route);
    _key.currentState!.push(route);
  }

  /// If [id] is provided closes loader with given [id]
  /// If not closes latest shown loader
  void hideLoader({Object? id}) {
    assert(
      id.isNull || _routes.where((element) => element.id == id).isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(_key.currentState.isNotNull, 'Tried to hide dialog but navigatorState was null. Key was :$_key');

    if (id.isNull) {
      _key.currentState!.removeRoute(_routes.removeLast());
    } else {
      final routeIndex = _routes.indexWhere((element) => element.id == id);
      _key.currentState!.removeRoute(_routes.removeAt(routeIndex));
    }
  }
}

/// A [DialogRoute] for showing loader
final class _LoaderRoute extends DialogRoute<Object> {
  @visibleForTesting
  _LoaderRoute({
    required super.context,
    required super.builder,
    this.id,
    super.barrierDismissible,
  });

  /// [id] of the [_LoaderRoute]
  final Object? id;
}
