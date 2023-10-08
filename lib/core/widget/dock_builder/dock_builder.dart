import 'package:flutter/material.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/core/dock/dock.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman/product/state/reactive/observer/observer.dart';
import 'package:liman/product/utils/logger.dart';

part '../default_appbar/default_appbar.dart';
part 'dock_builder_mixin.dart';

typedef WidgetCallback = Widget Function();

/// A SMART AND EASY [Widget] FOR MANAGING [PageState]
final class DockBuilder<T extends BaseViewModel> extends StatefulWidget {
  const DockBuilder({required this.viewModel, required this.onSuccess, super.key, this.onEmpty, this.onError, this.onLoading, this.onOffline});

  final T viewModel;
  final WidgetCallback onSuccess;
  final WidgetCallback? onLoading;
  final WidgetCallback? onEmpty;
  final WidgetCallback? onError;
  final WidgetCallback? onOffline;

  @override
  State<DockBuilder> createState() => _DockBuilderState();
}

class _DockBuilderState extends State<DockBuilder> with DockBuilderMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.closeKeyboard,
      child: Observer(
        builder: _buildPage,
      ),
    );
  }
}
