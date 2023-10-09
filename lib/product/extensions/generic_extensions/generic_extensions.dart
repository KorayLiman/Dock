import 'package:dock/product/state/reactive/observable/observable.dart';

/// GENERIC EXTENSION
extension GenericExtension<T extends Object> on T {
  /// Converts any Object of type T to Observable<T>
  Observable<T> get observable => Observable<T>(this);
}
