part of '../viewmodel/base_viewmodel.dart';

/// A MIXIN FOR HOLDING VARIABLES OF BASEVIEWMODEL
base mixin _BaseViewModelMixin {
  /// Route arguments
  late final dynamic arguments;

  /// View State notifier
  final _pageState = ValueNotifier(PageState.success);

  /// Getter of pageStateNotifier
  ValueNotifier<PageState> get getPageStateNotifier => _pageState;

  /// Gives current view state (success, loading, empty, error, offline)
  PageState get pageState => _pageState.value;

  /// Sets view state (success, loading, empty, error, offline)
  //ignore: use_setters_to_change_properties
  void setPageState(PageState newPageState) => _pageState.value = newPageState;
}
