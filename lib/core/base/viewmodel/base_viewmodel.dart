import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:liman/core/dock/dock.dart';
import 'package:liman/core/widget/dock_builder/dock_builder.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman/product/state/primitive/docker/docker.dart';

part '../../../product/state/primitive/docker/docker_stateless_element_mixin.dart';
part '../mixins/base_viewmodel_mixin.dart';

typedef DockerUpdater = void Function();

/// [PageState]
enum PageState { success, loading, empty, error, offline }

/// AN ABSTRACT [BaseViewModel] CLASS FOR CONTROLLING VIEW.
///
/// AIM OF THIS CLASS IS LEAVING UI THINGS TO VIEW AND PUTTING ALL THE METHODS HERE.
///
/// YOU WILL HAVE FULL CONTROL OVER STATE OF VIEW
abstract base class BaseViewModel<T extends Object> with _BaseViewModelMixin {
  /// Called when View is created
  @mustCallSuper
  void onInit(BuildContext stateContext) {
    _assertDockBuilderInitialized();
    Dock
      ..registerPostFrameCallback(onEndOfFrame)
      ..registerNextFrameCallback(onNextFrame);
  }

  /// Called after onInit. Handle network requests, navigation etc. here
  @mustCallSuper
  void onReady() {
    _assertDockBuilderInitialized();
  }

  /// Called at the end of the first frame of page render
  @mustCallSuper
  void onEndOfFrame(Duration timeStamp) {
    _assertDockBuilderInitialized();
  }

  /// Called at the beginning of the second frame of page render
  @mustCallSuper
  void onNextFrame(Duration timeStamp) {
    _assertDockBuilderInitialized();
  }

  /// Called when view is getting disposed
  @mustCallSuper
  void onDispose() {
    _assertDockBuilderInitialized();
  }
}
