part of 'state_builder.dart';

/// MIXIN FOR [StateBuilder] STATE
mixin StateBuilderMixin<T extends BaseViewModel> on State<StateBuilder> {
  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

  /// Builds page according to [PageState]
  Widget _buildPage(BuildContext context) => switch (widget.viewModel.pageState) {
        PageState.success => widget.onSuccess(context),
        PageState.loading => widget.onLoading != null
            ? widget.onLoading!(context)
            : Dock.defaultOnLoadingWidgetBuilder != null
                ? Dock.defaultOnLoadingWidgetBuilder!(context)
                : const Scaffold(
                    appBar: _DefaultAppBar(),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
        PageState.empty => widget.onEmpty != null
            ? widget.onEmpty!(context)
            : Dock.defaultOnEmptyWidgetBuilder != null
                ? Dock.defaultOnEmptyWidgetBuilder!(context)
                : const Scaffold(
                    appBar: _DefaultAppBar(),
                    body: Center(
                      child: Icon(
                        Icons.data_array,
                        size: _defaultIconSize,
                      ),
                    ),
                  ),
        PageState.error => widget.onError != null
            ? widget.onError!(context)
            : Dock.defaultOnErrorWidgetBuilder != null
                ? Dock.defaultOnErrorWidgetBuilder!(context)
                : const Scaffold(
                    appBar: _DefaultAppBar(),
                    body: Center(
                      child: Icon(
                        Icons.error_outline_rounded,
                        size: _defaultIconSize,
                        // color: AppConstants.appColors.yellowCommon,
                      ),
                    ),
                  ),
        PageState.offline => widget.onOffline != null
            ? widget.onOffline!(context)
            : Dock.defaultOnOfflineWidgetBuilder != null
                ? Dock.defaultOnOfflineWidgetBuilder!(context)
                : const Scaffold(
                    appBar: _DefaultAppBar(),
                    body: Center(
                      child: Icon(
                        Icons.signal_wifi_connected_no_internet_4,
                        size: _defaultIconSize,
                      ),
                    ),
                  ),
      };

  /* BEGIN WIDGET LIFECYCLES
  >>>>>>>>>>>>>>>>>>>>>>>
  */

  @override
  void initState() {
    widget.viewModel.markStateBuilderInitialized(widget);
    widget.viewModel.onInit(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.viewModel.onDependenciesChange();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.viewModel.onDispose();
    final vModel = Locator.tryFind<T>();
    if (vModel.hashCode == widget.viewModel.hashCode) {
      final result = Locator.unregister<T>();
      if (result) {
        Logger.logMsg(msg: "'$T' Unregistered", color: LogColors.red);
      } else {
        Logger.logMsg(msg: "---ERROR--- '$T' is registered but a problem occurred while unregistering it", color: LogColors.red);
      }
    } else {
      Logger.logMsg(msg: "Page disposed. No registered '$T' found", color: LogColors.white);
    }
    super.dispose();
  }
/* END WIDGET LIFECYCLES
<<<<<<<<<<<<<<<<<<<<<
 */
}