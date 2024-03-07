part of '../viewmodel/base_viewmodel.dart';

/// A MIXIN HOLDS VARIABLES OF [BaseViewModel]
base mixin _BaseViewModelMixin {
  /// Route [arguments]
  late final dynamic arguments;

  /// [BuildContext] of View e.g(LoginView) associated with this viewmodel
  late final BuildContext rootContext;

  /// Triggers rebuild for View associated with this ViewModel
  void rebuild() => rootContext.rebuildWidget();
}
