import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';

final class DockerStatelessElement = StatelessElement with DockerStatelessElementMixin;

@immutable
abstract base class DockerBaseStatelessWidget<T extends BaseViewModel> extends StatelessWidget {
  const DockerBaseStatelessWidget({required this.id, required this.viewModel, required this.builder, super.key});

  final String id;
  final T viewModel;
  final Widget Function(T viewModel) builder;

  @override
  StatelessElement createElement() {
    return DockerStatelessElement(this);
  }
}

final class Docker<T extends BaseViewModel> extends DockerBaseStatelessWidget<T> {
  const Docker({required super.id, required super.viewModel, required super.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return builder.call(viewModel);
  }
}
