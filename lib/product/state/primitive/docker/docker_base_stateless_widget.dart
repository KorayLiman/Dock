import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/product/state/primitive/docker/docker_stateless_element.dart';

@immutable

/// Parent class of Docker extends [StatelessWidget] contains it's properties
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
