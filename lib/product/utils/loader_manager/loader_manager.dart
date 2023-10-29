import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

/// A [DialogRoute] shows [CircularProgressIndicator] in center
final class LoaderRoute extends DialogRoute<dynamic> {
  LoaderRoute({
    required super.context,
    required super.builder,
    this.id,
    super.barrierDismissible,
  });

  final Object? id;
}

/// Helper class for showing loader dialog
///
/// [NavigatorState] key is required either of Root or Nested Navigator's
///
/// Override [loaderBuilder] if you want to use custom [Widget]
final class LoaderManager {
  LoaderManager(this._key);

  final GlobalKey<NavigatorState> _key;
  static List<LoaderRoute>? _routes;
  WidgetCallbackViaContext loaderBuilder = (BuildContext context) => const Center(
        child: CircularProgressIndicator(),
      );

  /// Shows loader dialog
  /// Provide [id] id if you have multiple loaders and want to close a specific one
  void show({Object? id, bool barrierDismissible = false}) {
    assert(_key.currentState.isNotNull, 'Tried to show dialog but navigatorState was null. Key was :$_key');
    final navigatorState = _key.currentState!;
    _routes ??= <LoaderRoute>[];
    assert(
      id.isNull || _routes!.where((element) => element.id == id).toList().isEmpty,
      'There is already a loader showing with id: $id',
    );

    final route = LoaderRoute(
      id: id,
      barrierDismissible: barrierDismissible,
      context: navigatorState.context,
      builder: loaderBuilder,
    );

    _routes!.add(route);
    navigatorState.push(route);
  }

  /// If [id] is provided closes loader with given [id]
  /// If not closes latest shown loader
  void hide({Object? id}) {
    if (_routes.isNull) {
      Logger.logMsg(
        msg: 'There is no loader to hide',
        color: LogColors.red,
      );
      return;
    }
    assert(
      id.isNull || _routes!.where((element) => element.id == id).toList().isNotEmpty,
      'Tried to close loader with id: $id which does not exist',
    );
    assert(_key.currentState.isNotNull, 'Tried to hide dialog but navigatorState was null. Key was :$_key');
    final navigatorState = _key.currentState!;
    if (id.isNull) {
      navigatorState.removeRoute(_routes!.removeLast());
      if (_routes!.isEmpty) {
        _routes = null;
      }
    } else {
      final routeIndex = _routes!.indexWhere((element) => element.id == id);
      navigatorState.removeRoute(_routes!.removeAt(routeIndex));
      if (_routes!.isEmpty) {
        _routes = null;
      }
    }
  }
}
