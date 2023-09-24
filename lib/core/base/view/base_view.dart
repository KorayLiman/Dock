import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman/product/utils/logger.dart';

typedef WidgetCallback = Widget Function();

final class BaseView extends StatefulWidget {
  const BaseView({required this.viewModel, required this.onSuccess, super.key, this.onEmpty, this.onError, this.onLoading, this.onOffline});

  final BaseViewModel viewModel;
  final WidgetCallback onSuccess;
  final WidgetCallback? onLoading;
  final WidgetCallback? onEmpty;
  final WidgetCallback? onError;
  final WidgetCallback? onOffline;

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  void initState() {
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
    Locator.unregister(instance: widget.viewModel);
    Logger.logMsg(msg: "'${widget.viewModel.runtimeType}' Unregistered", color: LogColors.red);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.turnOffKeyboard,
      child: ValueListenableBuilder<PageState>(
        valueListenable: widget.viewModel.getPageStateNotifier,
        builder: (context, pageState, child) {
          return buildPage(context);
        },
      ),
    );
  }

  Widget buildPage(BuildContext context) {
    return switch (widget.viewModel.pageState) {
      PageState.success => widget.onSuccess(),
      PageState.loading => widget.onLoading != null
          ? widget.onLoading!()
          : Scaffold(
              // appBar: CustomAppBars.appBarTitleOnly(context: context, title: ""),
              body: Center(
                  child: CircularProgressIndicator(
                      // color: AppConstants.appColors.yellowCommon,
                      )),
            ),
      PageState.empty => widget.onEmpty != null
          ? widget.onEmpty!()
          : Scaffold(
              // appBar: CustomAppBars.appBarTitleOnly(
              //   context: context,
              //   title: LocaleKeys.errors_sorry.tr(),
              // ),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    // color: AppConstants.appColors.yellowCommon,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Text(
                  //   LocaleKeys.page_state_errors_no_data.tr(),
                  //   style: CustomStyles.basierRegularWhite(fontSize: 14),
                  // ),
                ],
              )),
            ),
      PageState.error => widget.onError != null
          ? widget.onError!()
          : Scaffold(
              // appBar: CustomAppBars.appBarTitleOnly(
              //   context: context,
              //   title: LocaleKeys.errors_sorry.tr(),
              // ),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    // color: AppConstants.appColors.yellowCommon,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Text(
                  //   LocaleKeys.page_state_errors_data_retrieve_error.tr(),
                  //   style: CustomStyles.basierRegularWhite(fontSize: 14),
                  // ),
                ],
              )),
            ),
      PageState.offline => widget.onOffline != null
          ? widget.onOffline!()
          : Scaffold(
              // appBar: CustomAppBars.appBarLeadingTitle(context: context, title: LocaleKeys.errors_sorry.tr(), callback: viewModel.back),
              body: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    // color: AppConstants.appColors.yellowCommon,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // Text(
                  //   LocaleKeys.page_state_errors_connection_error.tr(),
                  //   style: CustomStyles.basierRegularWhite(fontSize: 14),
                  // ),
                ],
              )),
            ),
    };
  }
}
