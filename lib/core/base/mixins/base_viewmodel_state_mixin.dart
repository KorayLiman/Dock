part of '../viewmodel/base_viewmodel.dart';

/// A MIXIN HOLDS STATE OF [BaseViewModel]
base mixin _BaseViewModelStateMixin {
  /// [PageState] observable
  final _pageState = PageState.success.observable;

  /// Gives current state of [PageState]
  PageState get pageState => _pageState.value;

  /// Sets [PageState]
  //ignore: use_setters_to_change_properties
  void setPageState(PageState newPageState) => _pageState.value = newPageState;

  /// Holds the initialization state of any [StateBuilder] associated with this viewmodel
  bool _isStateBuilderInitialized = false;

  /// Sets the initialization state of created [StateBuilder] associated with this viewmodel
  void markStateBuilderInitialized(StateBuilder stateBuilder) {
    _isStateBuilderInitialized = true;
  }

  /// If any widget lifecycle method is called by user manually(which shouldn't happen) and
  /// no [StateBuilder] created associated with this viewmodel warn user
  void _assertStateBuilderInitialized() {
    assert(
      _isStateBuilderInitialized,
      "You called a widget lifecycle method but didn't create any StateBuilder for current viewmodel.\nAlso it's not sensible calling any widget lifecycle methods manually from outside",
    );
  }

  /// Map holds [Docker] id's and updaters bound to this viewmodel
  Map<String, DockerUpdater>? _dockerUpdaters;

  /// Checks if any [Docker] exits with given id
  bool _containsDockerUpdater({required String id}) {
    return _dockerUpdaters!.containsKey(id);
  }

  /// Updates [Docker] bound to this viewmodel with given id
  void update({required String id}) {
    assert(_dockerUpdaters?.containsKey(id) ?? false, "You called update() method on Docker doesn't exist or disposed");
    final updater = _dockerUpdaters!.entries.where((element) => element.key == id).toList()[0].value;
    updater.call();
  }

  /// Updates [Docker]s bound to this viewmodel with given ids
  void updateMany({required List<String> ids}) {
    final notFoundIds = <String>[];
    assert(
      () {
        for (final id in ids) {
          if (_dockerUpdaters.notContainsKey(id)) {
            notFoundIds.add(id);
            return false;
          }
        }
        return true;
      }(),
      "Couldn't find any Docker with ids: $notFoundIds",
    );

    for (final id in ids) {
      final updater = _dockerUpdaters!.entries.where((element) => element.key == id).toList()[0].value;
      updater.call();
    }
  }

  /// Updates [Docker] bound to this viewmodel with given id after callback is executed
  void updateAfter({required String id, required VoidCallback after}) {
    assert(_dockerUpdaters?.containsKey(id) ?? false, "You called update() method on Docker doesn't exist or disposed");
    after.call();
    final updater = _dockerUpdaters!.entries.where((element) => element.key == id).toList()[0].value;
    updater.call();
  }
}
