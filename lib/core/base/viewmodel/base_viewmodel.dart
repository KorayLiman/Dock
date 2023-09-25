import 'package:flutter/material.dart';

part '../mixin/base_viewmodel_mixin.dart';

/// VIEW STATES
enum PageState { success, loading, empty, error, offline }

/// AN ABSTRACT BASE VIEWMODEL CLASS FOR CONTROLLING VIEW.
/// AIM OF THIS CLASS IS LEAVING UI THINGS TO VIEW AND PUTTING ALL THE METHODS HERE.
/// YOU WILL HAVE FULL CONTROL OVER VIEW STATE
abstract base class BaseViewModel<T extends Object> with _BaseViewModelMixin {
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
