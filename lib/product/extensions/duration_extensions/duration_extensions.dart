import 'dart:async';

/// [Duration] EXTENSIONS
extension DurationExtension on Duration {
  /// Converts duration object to Future with an optional callback
  Future<dynamic> delay([FutureOr<dynamic> Function()? callback]) async => Future.delayed(this, callback);
}
