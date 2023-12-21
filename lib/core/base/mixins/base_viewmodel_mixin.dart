part of '../viewmodel/base_viewmodel.dart';

/// A MIXIN HOLDS VARIABLES OF [BaseViewModel]
base mixin _BaseViewModelMixin {
  /// Route [arguments]
  late final dynamic arguments;

  /// [BuildContext] of [StateBuilder] associated with this viewmodel
  late final BuildContext stateBuilderContext;
}
