part of 'base_view.dart';

mixin BaseViewMixin<T extends BaseViewModel> on State<BaseView> {
  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

  T get _viewModel => widget.viewModel as T;

  /// Returns widget based on the current [PageState]
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
