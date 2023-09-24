import 'package:flutter/material.dart';

enum PageState { success, loading, empty, error, offline }

/// AN ABSTRACT BASE VIEWMODEL CLASS FOR CONTROLLING UI AND STORING VARIABLES.
/// AIM OF THIS CLASS IS LEAVING VIEW RELATED THINGS TO VIEW AND PUTTING EVERYTHING OTHER HERE.
/// YOU WILL HAVE FULL CONTROL OVER VIEW STATE
abstract base class BaseViewModel {
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

  /// Called when View is created
  @mustCallSuper
  void onInit(BuildContext stateContext) {}

  /// Called after onInit. Handle network requests, navigation etc. here
  @mustCallSuper
  void onReady() {}

  /// Called when view is getting disposed
  @mustCallSuper
  void onDispose() {
    _pageState.dispose();
  }
}
