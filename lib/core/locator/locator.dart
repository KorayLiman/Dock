import 'package:get_it/get_it.dart';

/// SMART [Locator] SERVICE
abstract class Locator {
  Locator._();

  static final _locator = GetIt.instance;

  /// Registers given instance
  static T register<T extends Object>(T instance) {
    return _locator.registerSingleton<T>(instance);
  }

  /// Unregisters given instance or instance with type [T]
  static void unregister<T extends Object>({T? instance}) {
    _locator.unregister<T>(instance: instance);
  }

  /// Gets registered object with Type [T]
  static T get<T extends Object>() {
    return _locator.get<T>();
  }

  /// Tries to get registered object with Type [T]
  ///
  /// Returns null if couldn't
  static T? tryGet<T extends Object>() {
    return isRegistered<T>() ? _locator.get<T>() : null;
  }

  /// Checks if given instance or instance with type [T] is registered
  static bool isRegistered<T extends Object>({T? instance}) {
    return _locator.isRegistered<T>(instance: instance);
  }
}
