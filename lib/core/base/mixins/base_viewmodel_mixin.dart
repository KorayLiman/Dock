part of '../viewmodel/base_viewmodel.dart';

/// A MIXIN HOLDS VARIABLES OF [BaseViewModel]
base mixin _BaseViewModelMixin {
  /// Route [arguments]
  late final dynamic arguments;

  /// [PageState] observable
  final _pageState = PageState.success.observable;

  /// Gives current state of [PageState]
  PageState get pageState => _pageState.value;

  /// Sets [PageState]
  //ignore: use_setters_to_change_properties
  void setPageState(PageState newPageState) => _pageState.value = newPageState;

  /// Holds the initialization state of any [DockBuilder] associated with this viewmodel
  bool _isDockBuilderInitialized = false;

  /// Sets the initialization state of created [DockBuilder] associated with this viewmodel
  void markDockBuilderInitialized(DockBuilder dockBuilder) {
    _isDockBuilderInitialized = true;
  }

  /// If any widget lifecycle method is called by user manually(which shouldn't happen) and
  /// no [DockBuilder] created associated with this viewmodel warn user
  void _assertDockBuilderInitialized() {
    assert(
      _isDockBuilderInitialized,
      "You called a widget lifecycle method but didn't create any DockBuilder for current viewmodel.\nAlso it's not sensible calling any widget lifecycle methods manually from outside",
    );
  }
}