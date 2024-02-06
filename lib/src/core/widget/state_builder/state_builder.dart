import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';

/// A SMART AND EASY [Widget] FOR MANAGING [PageState]
class StateBuilder<T extends BaseViewModel> extends StatefulWidget {
  const StateBuilder({
    required this.viewModel,
    required this.onSuccess,
    super.key,
    this.onEmpty,
    this.onError,
    this.onLoading,
    this.onOffline,
  });

  final T viewModel;
  final WidgetBuilder onSuccess;
  final WidgetBuilder? onLoading;
  final WidgetBuilder? onEmpty;
  final WidgetBuilder? onError;
  final WidgetBuilder? onOffline;

  @override
  State<StateBuilder> createState() => _StateBuilderState<T>();
}

class _StateBuilderState<T extends BaseViewModel> extends State<StateBuilder> with StateBuilderMixin<T> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.closeKeyboard,
      child: Observer(
        builder: builder,
      ),
    );
  }
}
