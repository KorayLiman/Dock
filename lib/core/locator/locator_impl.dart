part of 'locator_service.dart';

/// Smart dependency management
class _LocatorImpl {
  /// Stored instances
  final _dependencyInstances = <String, _Instance>{};

  /// Generates key from given [type]
  String _getInstanceKey(Type type) {
    return type.toString();
  }

  /// Registers given instance
  T register<T extends Object>(T instance, {bool keepAlive = false}) {
    Dock.throwConditionalException(
      exception: LocatorException(message: 'Object of type $T is already registered'),
      throwIf: isRegistered<T>(instance: instance),
    );

    final instanceToRegister = _Instance<T>(builder: () => instance, keepAlive: keepAlive);
    instanceToRegister.instance = instanceToRegister.builder.call();
    _dependencyInstances[_getInstanceKey(T)] = instanceToRegister;
    return instance;
  }

  /// Registers given instance as new if already exists one.
  ///
  /// In other words: Replaces old instance or creates one.
  T registerAsNew<T extends Object>(T instance, {bool keepAlive = false}) {
    if (isRegistered<T>(instance: instance)) {
      unregister<T>(instance: instance);
    }

    final instanceToRegister = _Instance<T>(builder: () => instance, keepAlive: keepAlive);
    instanceToRegister.instance = instanceToRegister.builder.call();
    _dependencyInstances[_getInstanceKey(T)] = instanceToRegister;
    return instance;
  }

  /// Registers given instance to be created at first access
  void registerLazy<T extends Object>(InstanceBuilder<T> builder, {bool keepAlive = false}) {
    Dock.throwConditionalException(
      exception: LocatorException(message: 'Object of type $T is already registered'),
      throwIf: isRegistered<T>(),
    );

    final instanceToRegister = _Instance<T>(builder: builder, keepAlive: keepAlive);
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
    Dock.throwConditionalException(
      exception: LocatorException(message: 'Tried to find Object of type $T that is not registered'),
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
    final instanceKey = instance == null ? _getInstanceKey(T) : _getInstanceKey(instance.runtimeType);
    return _dependencyInstances[instanceKey] != null;
  }
}

/// Registered [_Instance] model
class _Instance<T extends Object> {
  _Instance({required this.builder, required this.keepAlive});

  final InstanceBuilder<T> builder;
  final bool keepAlive;
  T? instance;
}
