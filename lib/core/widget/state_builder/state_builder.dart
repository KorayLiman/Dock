import 'package:dock_flutter/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/core/dock/dock_main.dart';
import 'package:dock_flutter/core/locator/locator.dart';
import 'package:dock_flutter/product/extensions/extensions.dart';
import 'package:dock_flutter/product/state/reactive/observer/observer.dart';
import 'package:dock_flutter/product/utils/logger/logger.dart';
import 'package:dock_flutter/typedefs.dart';
import 'package:flutter/material.dart';

part '../default_appbar/default_appbar.dart';
part 'state_builder_mixin.dart';

/// A SMART AND EASY [Widget] FOR MANAGING [PageState]
final class StateBuilder<T extends BaseViewModel> extends StatefulWidget {
  const StateBuilder({required this.viewModel, required this.onSuccess, super.key, this.onEmpty, this.onError, this.onLoading, this.onOffline});

  final T viewModel;
  final WidgetCallbackViaContext onSuccess;
  final WidgetCallbackViaContext? onLoading;
  final WidgetCallbackViaContext? onEmpty;
  final WidgetCallbackViaContext? onError;
  final WidgetCallbackViaContext? onOffline;

  @override
  State<StateBuilder> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T extends BaseViewModel> extends State<StateBuilder> with StateBuilderMixin<T> {
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
