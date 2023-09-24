import 'package:flutter/material.dart';

enum PageState { success, loading, empty, error, offline }

abstract base class BaseViewModel {
  late final dynamic arguments;
  final _pageState = ValueNotifier(PageState.success);

  ValueNotifier<PageState> get getPageStateNotifier => _pageState;

  PageState get pageState => _pageState.value;

  //ignore: use_setters_to_change_properties
  void setPageState(PageState newPageState) => _pageState.value = newPageState;

  @mustCallSuper
  void onInit(BuildContext stateContext) {}

  @mustCallSuper
  void onReady() {}

  @mustCallSuper
  void onDispose() {
    _pageState.dispose();
  }
}
