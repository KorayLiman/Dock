import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liman/core/base/viewmodel/base_viewmodel.dart';

/// FLUTTER'S DEFAULT [TickerProviderStateMixin] SUITABLE FOR VIEWMODEL'S EXTEND FROM [BaseViewModel]
@optionalTypeArgs
base mixin TickerProviderViewModelMixin<T extends BaseViewModel> on BaseViewModel<T> implements TickerProvider {
  Set<Ticker>? _tickers;

  BuildContext get context;

  @override
  Ticker createTicker(TickerCallback onTick) {
    if (_tickerModeNotifier == null) {
      // Setup TickerMode notifier before we vend the first ticker.
      _updateTickerModeNotifier();
    }
    assert(_tickerModeNotifier != null, 'TickerModeNotifier is null');
    _tickers ??= <_WidgetTicker>{};
    final result = _WidgetTicker(onTick, this, debugLabel: kDebugMode ? 'created by ${describeIdentity(this)}' : null)..muted = !_tickerModeNotifier!.value;
    _tickers!.add(result);
    return result;
  }

  void _removeTicker(_WidgetTicker ticker) {
    assert(_tickers != null, 'Tickers is empty');
    assert(_tickers!.contains(ticker), "Tickers doesn't containt $ticker");
    _tickers!.remove(ticker);
  }

  ValueListenable<bool>? _tickerModeNotifier;

  void _updateTickers() {
    if (_tickers != null) {
      final muted = !_tickerModeNotifier!.value;
      for (final ticker in _tickers!) {
        ticker.muted = muted;
      }
    }
  }

  void _updateTickerModeNotifier() {
    final newNotifier = TickerMode.getNotifier(context);
    if (newNotifier == _tickerModeNotifier) {
      return;
    }
    _tickerModeNotifier?.removeListener(_updateTickers);
    newNotifier.addListener(_updateTickers);
    _tickerModeNotifier = newNotifier;
  }

  @override
  void onDispose() {
    //ignore: prefer_asserts_with_message
    assert(() {
      if (_tickers != null) {
        for (final ticker in _tickers!) {
          if (ticker.isActive) {
            throw FlutterError.fromParts(<DiagnosticsNode>[
              ErrorSummary('$this was disposed with an active Ticker.'),
              ErrorDescription(
                '$runtimeType created a Ticker via its TickerProviderViewModelMixin, but at the time '
                'dispose() was called on the mixin, that Ticker was still active. All Tickers must '
                'be disposed before calling super.dispose().',
              ),
              ErrorHint(
                'Tickers used by AnimationControllers '
                'should be disposed by calling dispose() on the AnimationController itself. '
                'Otherwise, the ticker will leak.',
              ),
              ticker.describeForError('The offending ticker was'),
            ]);
          }
        }
      }
      return true;
    }());
    _tickerModeNotifier?.removeListener(_updateTickers);
    _tickerModeNotifier = null;
    super.onDispose();
  }
}

// This class should really be called _DisposingTicker or some such, but this
// class name leaks into stack traces and error messages and that name would be
// confusing. Instead we use the less precise but more anodyne "_WidgetTicker",
// which attracts less attention.
class _WidgetTicker extends Ticker {
  _WidgetTicker(super.onTick, this._creator, {super.debugLabel});

  final TickerProviderViewModelMixin _creator;

  @override
  void dispose() {
    _creator._removeTicker(this);
    super.dispose();
  }
}
