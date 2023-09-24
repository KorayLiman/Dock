import 'package:get_it/get_it.dart';

abstract class Locator {
  Locator._();

  static final _locator = GetIt.instance;

  static T register<T extends Object>(T instance) {
    return _locator.registerSingleton<T>(instance);
  }

  static void unregister<T extends Object>({T? instance}) {
    _locator.unregister<T>(instance: instance);
  }

  static T get<T extends Object>() {
    return _locator.get<T>();
  }

  static T? tryGet<T extends Object>() {
    return isRegistered<T>() ? _locator.get<T>() : null;
  }

  static bool isRegistered<T extends Object>({T? instance}) {
    return _locator.isRegistered<T>(instance: instance);
  }
}
