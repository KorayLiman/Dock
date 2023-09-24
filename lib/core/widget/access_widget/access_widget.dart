import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';

abstract class AccessWidget<T extends BaseViewModel> extends StatelessWidget {
  const AccessWidget({super.key});

  T get viewModel => Locator.get<T>();

  @override
  Widget build(BuildContext context);
}
