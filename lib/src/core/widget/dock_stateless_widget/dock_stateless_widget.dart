import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// A [StatelessWidget] provides getter for ViewModel provided type of [T]
abstract class DockStatelessWidget<T extends BaseViewModel> extends StatelessWidget {
  const DockStatelessWidget({super.key});

  T get viewModel => Locator.find<T>();
}
