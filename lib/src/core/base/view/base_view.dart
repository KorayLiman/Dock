import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

part 'base_view_state_mixin.dart';

/// An abstract [StatefulWidget] that provides a base for all views in the application.
abstract base class BaseView<T extends BaseViewModel> extends StatefulWidget {
  const BaseView({required this.viewModelCallback, super.key});

  final T Function() viewModelCallback;

  Widget onSuccess(BuildContext context, T viewModel);

  Widget? onLoading(BuildContext context, T viewModel) => null;

  Widget? onEmpty(BuildContext context, T viewModel) => null;

  Widget? onError(BuildContext context, T viewModel) => null;

  Widget? onOffline(BuildContext context, T viewModel) => null;

  @override
  State<BaseView> createState() => BaseViewState<T>._();
}

final class BaseViewState<T extends BaseViewModel> extends State<BaseView> with BaseViewStateMixin<T> {
  BaseViewState._();

  late final T viewModel;

  // ---------------------
  // BEGIN WIDGET LIFECYCLES
  // ---------------------
  @override
  void initState() {
    viewModel = widget.viewModelCallback() as T
      ..rootContext = context
      ..onInit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel.onDependenciesChange();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.onDispose();
    final vModel = Locator.tryFind<T>();
    if (vModel.hashCode == viewModel.hashCode) {
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
        builder: (observerContext) => _builder(observerContext, viewModel),
      ),
    );
  }
}
