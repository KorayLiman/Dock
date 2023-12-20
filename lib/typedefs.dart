import 'package:flutter/material.dart';

// STATE
typedef Updater = void Function();
typedef Disposer = void Function();
typedef ChangeGenericValue<T> = void Function(T object);
typedef WidgetCallback = Widget Function();
typedef DockerBuilderFn<T> = Widget Function(BuildContext context, T viewModel);
typedef DockerUpdater = void Function();

// DEPENDENCY INJECTION
typedef InstanceBuilder<T extends Object> = T Function();

// FRAME
typedef FrameCallback = void Function(Duration timeStamp);
