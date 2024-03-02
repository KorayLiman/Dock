import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// AN ABSTRACT [StatelessWidget] FOR OPTIONALLY REGISTERING VIEWMODEL OF ANY VIEW
// abstract base class BaseView<T extends BaseViewModel> extends StatelessWidget {
//   const BaseView({required this.viewModel, super.key});
//
//   /// [viewModel]
//   final T viewModel;
//
//   /// [build] method of [StatelessWidget] but returns [StateBuilder] instead of [Widget]
//   @override
//   @protected
//   StateBuilder build(BuildContext context);
// }

abstract base class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({required this.viewModel, super.key});

  final T viewModel;

  StateBuilder build(BuildContext context);

  @override
  State<BaseView> createState() => BaseViewState<T>._();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView> {
  BaseViewState._();

  T get _viewModel => widget.viewModel as T;

  @override
  void initState() {
    _viewModel
      ..rootContext = context
      ..onInit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel.onDependenciesChange();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);
}
