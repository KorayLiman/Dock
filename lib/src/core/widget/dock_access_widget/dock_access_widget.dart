import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// A CONST [StatelessWidget] FOR ACCESSING VIEWMODEL EASILY
abstract class DockAccess<T extends BaseViewModel> extends StatelessWidget {
  const DockAccess({super.key});

  T get viewModel => Locator.find<T>();

  @override
  Widget build(BuildContext context);
}
