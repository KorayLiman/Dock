part of 'dock_builder.dart';

/// MIXIN FOR [DockBuilder] STATE
mixin DockBuilderMixin<T extends BaseViewModel> on State<DockBuilder> {
  /// [PageState] default icon size
  static const double _defaultIconSize = 48;

  /// Builds page according to [PageState]
  Widget _buildPage(BuildContext context) => switch (widget.viewModel.pageState) {
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
