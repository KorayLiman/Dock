import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';

/// AN ABSTRACT STATELESS WIDGET FOR OPTIONALLY REGISTERING VIEWMODEL OF ANY VIEW
abstract base class BaseView<T extends BaseViewModel> extends StatelessWidget {
  BaseView({required T viewModel, dynamic arguments, bool inject = true, super.key}) {
    this.viewModel = inject ? Locator.register<T>(viewModel) : viewModel;
    this.viewModel.arguments = arguments;
  }

  late final T viewModel;
}
