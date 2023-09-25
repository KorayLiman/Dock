import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';

/// FLUTTER'S DEFAULT SINGLETICKERPROVIDER SUITABLE FOR VIEWMODEL'S EXTEND FROM BASEVIEWMODEL
@optionalTypeArgs
base mixin SingleTickerProviderViewModelMixin<T extends BaseViewModel> on BaseViewModel<T> implements TickerProvider {
  Ticker? _ticker;

  BuildContext get stateContext;

  @override
  Ticker createTicker(TickerCallback onTick) {
    //ignore: prefer_asserts_with_message
    assert(() {
      if (_ticker == null) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$runtimeType is a SingleTickerProviderViewModelMixin but multiple tickers were created.'),
        ErrorDescription('A SingleTickerProviderViewModelMixin can only be used as a TickerProvider once.'),
        ErrorHint(
          'If a State is used for multiple AnimationController objects, or if it is passed to other '
          'objects and those objects might use it more than one time in total, then instead of '
          'mixing in a SingleTickerProviderViewModelMixin, use a regular TickerProviderViewModelMixin.',
        ),
      ]);
    }());
    _ticker = Ticker(onTick, debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null);
    _updateTickerModeNotifier();
    _updateTicker(); // Sets _ticker.mute correctly.
    return _ticker!;
  }

  @override
  void onDispose() {
    //ignore: prefer_asserts_with_message
    assert(() {
      if (_ticker == null || !_ticker!.isActive) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('$this was disposed with an active Ticker.'),
        ErrorDescription(
          '$runtimeType created a Ticker via its SingleTickerProviderViewModelMixin, but at the time '
          'dispose() was called on the mixin, that Ticker was still active. The Ticker must '
          'be disposed before calling super.dispose().',
        ),
        ErrorHint(
          'Tickers used by AnimationControllers '
          'should be disposed by calling dispose() on the AnimationController itself. '
          'Otherwise, the ticker will leak.',
        ),
        _ticker!.describeForError('The offending ticker was'),
      ]);
    }());
    _tickerModeNotifier?.removeListener(_updateTicker);
    _tickerModeNotifier = null;
    super.onDispose();
  }

  ValueListenable<bool>? _tickerModeNotifier;

  void _updateTicker() {
    if (_ticker != null) {
      _ticker!.muted = !_tickerModeNotifier!.value;
    }
  }

  void _updateTickerModeNotifier() {
    final newNotifier = TickerMode.getNotifier(stateContext);
    if (newNotifier == _tickerModeNotifier) {
      return;
    }
    _tickerModeNotifier?.removeListener(_updateTicker);
    newNotifier.addListener(_updateTicker);
    _tickerModeNotifier = newNotifier;
  }
}
