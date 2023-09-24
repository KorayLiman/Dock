import 'dart:async';

extension DurationExtension on Duration {
  Future<dynamic> delay([FutureOr<dynamic> Function()? callback]) async => Future.delayed(this, callback);
}
