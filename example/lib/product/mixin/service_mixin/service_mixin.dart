import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/core.dart';

base mixin ServiceMixin<T extends BaseService> on BaseViewModel {
  T get service {
    assert(T.toString() != 'BaseService', 'Tried to get service of instance BaseService');
    return Locator.find<T>();
  }
}
