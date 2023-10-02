part of 'dock_builder.dart';

/// MIXIN FOR [DockBuilder] STATE
mixin DockBuilderMixin on State<DockBuilder> {
  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

  /// Builds page according to [PageState]
  Widget _buildPage() => switch (widget.viewModel.pageState) {
        PageState.success => widget.onSuccess(),
        PageState.loading => widget.onLoading != null
            ? widget.onLoading!()
            : Dock.defaultOnLoadingWidgetBuilder != null
                ? Dock.defaultOnLoadingWidgetBuilder!()
                : const Scaffold(
                    appBar: _DefaultAppBar(),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
        PageState.empty => widget.onEmpty != null
            ? widget.onEmpty!()
            : Dock.defaultOnEmptyWidgetBuilder != null
                ? Dock.defaultOnEmptyWidgetBuilder!()
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
            ? widget.onError!()
            : Dock.defaultOnErrorWidgetBuilder != null
                ? Dock.defaultOnErrorWidgetBuilder!()
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
            ? widget.onOffline!()
            : Dock.defaultOnOfflineWidgetBuilder != null
                ? Dock.defaultOnOfflineWidgetBuilder!()
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
    widget.viewModel.markDockBuilderInitialized(widget);
    widget.viewModel.onInit(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.viewModel.onReady();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    widget.viewModel.onDispose();
    if (Locator.isRegistered(instance: widget.viewModel)) {
      Locator.unregister(instance: widget.viewModel);
      Logger.logMsg(msg: "'${widget.viewModel.runtimeType}' Unregistered", color: LogColors.red);
    } else {
      Logger.logMsg(msg: "Page disposed. No registered '${widget.viewModel.runtimeType}' found", color: LogColors.white);
    }
    super.dispose();
  }
/* END WIDGET LIFECYCLES
<<<<<<<<<<<<<<<<<<<<<
 */
}
