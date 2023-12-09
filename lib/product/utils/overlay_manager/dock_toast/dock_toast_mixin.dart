part of 'dock_toast.dart';

/// Mixin hold constants of DockToast
mixin class _DockToastMixin {
  /// Default forward animation curve
  Cubic get _forwardAnimCurve => const Cubic(0.1, 0.8, 0.2, 1.275);

  /// Default reverse animation curve
  Cubic get _reverseAnimCurve => const Cubic(0.1, 0.8, 0.2, 1.100);

  /// Default padding of toast
  EdgeInsets get _toastPadding => const EdgeInsets.symmetric(horizontal: 16, vertical: 20);

  /// Default bottom toast animation begin offset
  Offset get _toastBottomBeginOffset => const Offset(0, 2);

  /// Default bottom toast animation end offset
  Offset get _toastBottomEndOffset => Offset.zero;

  /// Default top toast animation begin offset
  Offset get _toastTopBeginOffset => const Offset(0, -2);

  /// Default top toast animation end offset
  Offset get _toastTopEndOffset => Offset.zero;

  /// Default toast radius
  BorderRadius get _toastBorderRadius => BorderRadius.circular(15);

  /// Default toast color
  Color get _defaultToastColor => Colors.white;
}
