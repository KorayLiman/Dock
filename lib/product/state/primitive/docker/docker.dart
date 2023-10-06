import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/product/state/primitive/docker/docker_base_stateless_widget.dart';

/// Primitive (Manual) updatable [StatelessWidget] by it's [id]
final class Docker<T extends BaseViewModel> extends DockerBaseStatelessWidget<T> {
  const Docker({required super.id, required super.viewModel, required super.builder, super.key});

  @override
  Widget build(BuildContext context) {
    return builder.call(viewModel);
  }
}
