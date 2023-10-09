import 'package:dock/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock/core/locator/locator.dart';
import 'package:dock/core/widget/dock_builder/dock_builder.dart';
import 'package:flutter/material.dart';

/// AN ABSTRACT [StatelessWidget] FOR OPTIONALLY REGISTERING VIEWMODEL OF ANY VIEW
abstract base class BaseView<T extends BaseViewModel> extends StatelessWidget {
  BaseView({required T viewModel, dynamic arguments, bool inject = true, super.key}) {
    this.viewModel = inject ? Locator.register<T>(viewModel) : viewModel;
    this.viewModel.arguments = arguments;
  }

  /// Child [viewModel]
  late final T viewModel;

  /// [build] method of [StatelessWidget] but returns [DockBuilder] instead of [Widget]
  @override
  @protected
  DockBuilder build(BuildContext context);
}
