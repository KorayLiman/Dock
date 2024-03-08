part of 'base_view.dart';

mixin BaseViewStateMixin<T extends BaseViewModel> on State<BaseView> {
  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

  /// Returns widget based on the current [PageState]
  Widget _builder(BuildContext context, T viewModel) {
    return switch (viewModel.pageState) {
      PageState.success => widget.onSuccess(context, viewModel),
      PageState.loading => widget.onLoading(context, viewModel) ??
          (Dock.defaultOnLoadingWidgetBuilder != null
              ? Dock.defaultOnLoadingWidgetBuilder!(context, viewModel)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )),
      PageState.empty => widget.onEmpty(context, viewModel) ??
          (Dock.defaultOnEmptyWidgetBuilder != null
              ? Dock.defaultOnEmptyWidgetBuilder!(context, viewModel)
              : Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Icon(
                      Icons.data_array,
                      size: _defaultIconSize,
                    ),
                  ),
                )),
      PageState.error => widget.onError(context, viewModel) ??
          (Dock.defaultOnErrorWidgetBuilder != null
              ? Dock.defaultOnErrorWidgetBuilder!(context, viewModel)
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
      PageState.offline => widget.onOffline(context, viewModel) ??
          (Dock.defaultOnOfflineWidgetBuilder != null
              ? Dock.defaultOnOfflineWidgetBuilder!(context, viewModel)
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
