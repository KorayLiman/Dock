part of 'dock_toast.dart';

/// Mixin hold constants of DockToast
mixin class _DockToastDefaults {
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

  /// Default toast radius
  BorderRadius get _toastBorderRadius => BorderRadius.circular(15);

  /// Default toast color
  Color get _defaultToastColor => Colors.grey.shade400;

  /// Default shadow color
  Color get _defaultShadowColor => Colors.grey.shade400;

  /// Default above shadow offset
  Offset get _defaultToastShadowAboveOffset => const Offset(0, -1);

  /// Default below shadow offset
  Offset get _defaultTShadowBelowOffset => const Offset(0, 7);

  /// Default title text style
  TextStyle get _defaultTitleStyle => const TextStyle(color: Colors.black, fontWeight: FontWeight.bold);

  /// Default message text style
  TextStyle get _defaultMessageStyle => const TextStyle(color: Colors.white);

  /// Repositioning curve
  Curve get _repositioningCurve => Curves.elasticOut;

  /// Repositioning duration
  Duration get _repositioningDuration => 500.milliseconds;

  /// Default above shadow radius
  double get _defaultAboveShadowRadius => 0.5;

  /// Default below shadow radius
  double get _defaultBelowShadowRadius => 12;
}
