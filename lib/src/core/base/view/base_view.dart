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

  Widget onSuccess(BuildContext context);

  Widget? onLoading(BuildContext context) => null;

  Widget? onEmpty(BuildContext context) => null;

  Widget? onError(BuildContext context) => null;

  Widget? onOffline(BuildContext context) => null;

  @override
  State<BaseView> createState() => BaseViewState<T>._();
}

class BaseViewState<T extends BaseViewModel> extends State<BaseView> {
  BaseViewState._();

  T get _viewModel => widget.viewModel as T;

  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

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
      final result = Locator.unregister<T>();
      if (result) {
        Logger.logMsg(msg: "'$T' Unregistered", color: LogColors.red);
      } else {
        Logger.logMsg(msg: "---ERROR--- '$T' is registered but a problem occurred while unregistering it", color: LogColors.red);
      }
    } else {
      Logger.logMsg(msg: "Page disposed. No '$T' was registered", color: LogColors.white);
    }
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

  Widget _builder(BuildContext context) {
    return switch (_viewModel.pageState) {
      PageState.success => widget.onSuccess(context),
      PageState.loading => widget.onLoading(context) ??
          (Dock.defaultOnLoadingWidgetBuilder != null
              ? Dock.defaultOnLoadingWidgetBuilder!(context)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
      PageState.empty => widget.onEmpty(context) ??
          (Dock.defaultOnEmptyWidgetBuilder != null
              ? Dock.defaultOnEmptyWidgetBuilder!(context)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Icon(
                      Icons.data_array,
                      size: _defaultIconSize,
                    ),
                  ),
                )),
      PageState.error => widget.onError(context) ??
          (Dock.defaultOnErrorWidgetBuilder != null
              ? Dock.defaultOnErrorWidgetBuilder!(context)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Icon(
                      Icons.error_outline_rounded,
                      size: _defaultIconSize,
                      // color: AppConstants.appColors.yellowCommon,
                    ),
                  ),
                )),
      PageState.offline => widget.onOffline(context) ??
          (Dock.defaultOnOfflineWidgetBuilder != null
              ? Dock.defaultOnOfflineWidgetBuilder!(context)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Icon(
                      Icons.signal_wifi_connected_no_internet_4,
                      size: _defaultIconSize,
                    ),
                  ),
                )),
    };
  }
}
