import 'package:dock_flutter/src/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/src/core/locator/locator.dart';
import 'package:dock_flutter/src/product/extensions/object_extensions/object_extensions.dart';
import 'package:dock_flutter/src/typedefs.dart';
import 'package:flutter/material.dart';

/// Primitive (Manual) updatable [StatelessWidget] by it's [id]
final class Docker<T extends BaseViewModel> extends StatelessWidget {
  const Docker({required this.id, required this.builder, this.viewModel, super.key});

  final Object id;
  final T? viewModel;
  final DockerBuilderFn<T> builder;

  T get vModel => viewModel ?? Locator.find<T>();

  @override
  StatelessElement createElement() {
    assert(viewModel.isNotNull || Locator.tryFind<T>().isNotNull, """
    You didn't provide any viewModel or inserted one""");
    return DockerStatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return builder.call(context, vModel);
  }
}
