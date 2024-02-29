import 'package:dock_flutter/src/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/src/core/widget/state_builder/state_builder.dart';
import 'package:flutter/material.dart';

/// AN ABSTRACT [StatelessWidget] FOR OPTIONALLY REGISTERING VIEWMODEL OF ANY VIEW
abstract base class BaseView<T extends BaseViewModel> extends StatelessWidget {
  const BaseView({required this.viewModel, super.key});

  /// [viewModel]
  final T viewModel;

  /// [build] method of [StatelessWidget] but returns [StateBuilder] instead of [Widget]
  @override
  @protected
  StateBuilder build(BuildContext context);
}
