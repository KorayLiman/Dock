part of 'locator.dart';

typedef InstanceBuilder<T extends Object> = T Function();

/// Smart dependency management
class _LocatorImpl {
  /// Stored instances
  final _dependencyInstances = <String, _Instance>{};

  /// Gets key of instance in [_dependencyInstances]
  String _getInstanceKey(Type type) {
    return type.toString();
  }

  /// Registers given instance
  T register<T extends Object>(T instance, {bool keepAlive = false}) {
    Dock.throwConditional(
      exception: _LocatorException(message: 'Object of type $T is already registered'),
      throwIf: isRegistered<T>(instance: instance),
    );

    final instanceToRegister = _Instance<T>(builder: () => instance, keepAlive: keepAlive);
    instanceToRegister.instance = instanceToRegister.builder.call();
    _dependencyInstances[_getInstanceKey(T)] = instanceToRegister;
    return instance;
  }

  /// Registers given instance to be created at first access
  void registerLazy<T extends Object>(T instance, {bool keepAlive = false}) {
    Dock.throwConditional(
      exception: _LocatorException(message: 'Object of type $T is already registered'),
      throwIf: isRegistered<T>(instance: instance),
    );

    final instanceToRegister = _Instance<T>(builder: () => instance, keepAlive: keepAlive);
    _dependencyInstances[_getInstanceKey(T)] = instanceToRegister;
  }

  /// Unregisters given instance or instance of type [T]
  bool unregister<T extends Object>({T? instance, bool force = false}) {
    if (isRegistered<T>(instance: instance)) {
      final inst = _dependencyInstances[instance == null ? _getInstanceKey(T) : _getInstanceKey(instance.runtimeType)];
      if (inst!.keepAlive && !force) return false;
      _dependencyInstances.remove(instance == null ? _getInstanceKey(T) : _getInstanceKey(instance.runtimeType));
      return true;
    }
    return false;
  }

  /// Unregisters all instances
  void unregisterAll({bool force = false}) {
    if (force) {
      _dependencyInstances.clear();
    } else {
      _dependencyInstances.removeWhere((key, value) => !value.keepAlive);
    }
  }

  /// Finds registered instance of Type [T]
  ///
  /// Throws if couldn't
  T find<T extends Object>() {
    Dock.throwConditional(
      exception: _LocatorException(message: 'Tried to find Object of type $T that is not registered'),
      throwIf: !isRegistered<T>(),
    );
    final instance = _dependencyInstances[_getInstanceKey(T)];
    if (instance!.instance.isNull) {
      instance.instance = instance.builder.call();
    }
    return instance.instance! as T;
  }

  /// Tries to find registered instance of Type [T]
  ///
  /// Returns null if couldn't
  T? tryFind<T extends Object>() {
    if (!isRegistered<T>()) return null;
    final instance = _dependencyInstances[_getInstanceKey(T)];
    if (instance!.instance.isNull) {
      instance.instance = instance.builder.call();
    }
    return instance.instance! as T;
  }

  /// Checks if given instance or instance of type [T] is registered
  bool isRegistered<T extends Object>({T? instance}) {
    return _dependencyInstances.containsKey(instance == null ? _getInstanceKey(T) : _getInstanceKey(instance.runtimeType));
  }
}

/// Registered [_Instance] model
class _Instance<T extends Object> {
  _Instance({required this.builder, required this.keepAlive});

  InstanceBuilder<T> builder;
  bool keepAlive;
  T? instance;
}
