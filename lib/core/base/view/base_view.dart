import 'package:dock_flutter/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/core/locator/locator.dart';
import 'package:dock_flutter/core/widget/state_builder/state_builder.dart';
import 'package:flutter/material.dart';

/// AN ABSTRACT [StatelessWidget] FOR OPTIONALLY REGISTERING VIEWMODEL OF ANY VIEW
abstract base class BaseView<T extends BaseViewModel> extends StatelessWidget {
  BaseView({required T viewModel, dynamic arguments, ViewConfig viewConfig = const ViewConfig(inject: true), super.key}) {
    if (viewConfig.inject) {
      if (viewConfig.asNewInstance) {
        this.viewModel = Locator.registerAsNew<T>(viewModel);
      } else {
        this.viewModel = Locator.register<T>(viewModel);
      }
    } else {
      this.viewModel = viewModel;
    }

    this.viewModel.arguments = arguments;
  }

  /// [viewModel]
  late final T viewModel;

  /// [build] method of [StatelessWidget] but returns [StateBuilder] instead of [Widget]
  @override
  @protected
  StateBuilder build(BuildContext context);
}

/// Configuration for [View]
final class ViewConfig {
  const ViewConfig({required this.inject, this.asNewInstance = true});

  final bool inject;
  final bool asNewInstance;
}
