import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'LoaderOverlayRoute')
class LoaderDialog extends StatelessWidget {
  const LoaderDialog({super.key, this.loader});

  final Widget? loader;

  @override
  Widget build(BuildContext context) {
    return loader ??
        const Center(
          child: CircularProgressIndicator(),
        );
  }
}
