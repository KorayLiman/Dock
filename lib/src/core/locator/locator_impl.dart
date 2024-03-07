part of 'locator_service.dart';

/// Smart dependency management
class _LocatorImpl {
  /// Stored instances
  final _dependencyInstances = <String, _Instance>{};

  /// Generates key from given [type] and [tag]
  String _getInstanceKey(Type type, String? tag) {
    return '$type$tag';
  }

  /// Registers given [instance] with given [tag]
  ///
  /// If instance of type [T] is already registered it will look at the [strategy]
  /// If [strategy] is [RegisterStrategy.doNotOverride] it will throw an exception
  /// Otherwise it will override the existing instance
  T register<T extends Object>(T instance, {String? tag, RegisterStrategy strategy = RegisterStrategy.doNotOverride}) {
    if (isRegistered<T>(tag: tag)) {
      if (strategy == RegisterStrategy.override) {
        unregister<T>(tag: tag);
      } else {
        throw LocatorException(message: 'Object of type $T is already registered');
      }
    }
    final instanceToRegister = _Instance<T>(builder: () => instance, tag: tag);
    instanceToRegister.instance = instanceToRegister.builder.call();
    _dependencyInstances[_getInstanceKey(T, tag)] = instanceToRegister;
    Logger.logMsg(msg: 'Registered Object of type $T');
    return instance;
  }

  /// Registers a lazy instance with given [tag] to be created at first access
  void registerLazy<T extends Object>(InstanceBuilder<T> builder, {String? tag}) {
    Dock.throwConditionalException(
      exception: LocatorException(message: 'Object of type $T is already registered'),
      throwIf: isRegistered<T>(tag: tag),
    );

    final instanceToRegister = _Instance<T>(builder: builder, tag: tag);
    _dependencyInstances[_getInstanceKey(T, tag)] = instanceToRegister;
    Logger.logMsg(msg: 'Registered Lazy Object of type $T');
  }

  /// Unregisters given instance or instance of type [T] with given [tag]
  void unregister<T extends Object>({String? tag}) {
    if (isRegistered<T>(tag: tag)) {
      _dependencyInstances.remove(_getInstanceKey(T, tag));
      Logger.logMsg(msg: 'Unregistered Object of type $T');
    } else {
      throw LocatorException(message: 'Tried to unregister Object of type $T that is not registered');
    }
  }

  /// Unregisters all instances
  void unregisterAll() {
    _dependencyInstances.clear();
  }

  /// Finds registered instance of Type [T] with given [tag]
  ///
  /// Throws if couldn't
  T find<T extends Object>({String? tag}) {
    Dock.throwConditionalException(
      exception: LocatorException(message: 'Tried to find Object of type $T that is not registered'),
      throwIf: !isRegistered<T>(tag: tag),
    );
    final instance = _dependencyInstances[_getInstanceKey(T, tag)];
    if (instance!.instance.isNull) {
      instance.instance = instance.builder.call();
    }
    return instance.instance! as T;
  }

  /// Tries to find registered instance of Type [T] with given [tag]
  ///
  /// Returns null if couldn't
  T? tryFind<T extends Object>({String? tag}) {
    if (!isRegistered<T>(tag: tag)) return null;
    final instance = _dependencyInstances[_getInstanceKey(T, tag)];
    if (instance!.instance.isNull) {
      instance.instance = instance.builder.call();
    }
    return instance.instance! as T;
  }

  /// Checks if given instance or instance of type [T] with given [tag] is registered
  bool isRegistered<T extends Object>({String? tag}) {
    return _dependencyInstances[_getInstanceKey(T, tag)] != null;
  }
}

/// Registered [_Instance] model
class _Instance<T extends Object> {
  _Instance({required this.builder, this.tag});

  T? instance;
  final InstanceBuilder<T> builder;
  final String? tag;
}
