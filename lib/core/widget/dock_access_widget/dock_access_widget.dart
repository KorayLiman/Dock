import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';

/// A CONST [StatelessWidget] FOR ACCESSING VIEWMODEL EASILY
abstract class DockAccess<T extends BaseViewModel> extends StatelessWidget {
  const DockAccess({super.key});

  T get viewModel => Locator.get<T>();

  @override
  Widget build(BuildContext context);
}
