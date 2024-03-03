import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

part 'base_view_mixin.dart';

/// An abstract [StatefulWidget] that provides a base for all views in the application.
abstract base class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({required this.viewModel, super.key});

  final T viewModel;

  Widget onSuccess(BuildContext context);

  Widget? onLoading(BuildContext context) => null;

  Widget? onEmpty(BuildContext context) => null;

  Widget? onError(BuildContext context) => null;

  Widget? onOffline(BuildContext context) => null;

  @override
  State<BaseView> createState() => BaseViewState<T>._();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView> with BaseViewMixin<T> {
  BaseViewState._();

  // ---------------------
  // BEGIN WIDGET LIFECYCLES
  // ---------------------
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
    final vModel = Locator.tryFind<T>();
    if (vModel.hashCode == _viewModel.hashCode) {
      Locator.unregister<T>();
    }
    Logger.logMsg(msg: '${widget.runtimeType} disposed', color: LogColors.white);
    super.dispose();
  }

  // ---------------------
  // END WIDGET LIFECYCLES
  // ---------------------

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.closeKeyboard,
      child: Observer(
        builder: _builder,
      ),
    );
  }
}
