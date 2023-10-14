import 'package:dock_flutter/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

/// Primitive (Manual) updatable [StatelessWidget] by it's [id]
final class Docker<T extends BaseViewModel> extends StatelessWidget {
  const Docker({required this.id, required this.viewModel, required this.builder, super.key});

  final String id;
  final T viewModel;
  final DockerBuilderFn<T> builder;

  @override
  StatelessElement createElement() {
    return DockerStatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return builder.call(context, viewModel);
  }
}
