import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter/src/typedefs.dart';
import 'package:flutter/material.dart';

part '../../../product/state/primitive/docker/docker_stateless_element.dart';
part '../../widget/default_appbar/default_appbar.dart';
part '../../widget/state_builder/state_builder_mixin.dart';
part '../mixins/base_viewmodel_mixin.dart';
part '../mixins/base_viewmodel_state_mixin.dart';

/// [PageState]
enum PageState { success, loading, empty, error, offline }

/// AN ABSTRACT [BaseViewModel] CLASS FOR CONTROLLING VIEW.
///
/// AIM OF THIS CLASS IS LEAVING UI THINGS TO VIEW AND PUTTING ALL THE METHODS HERE.
///
/// YOU WILL HAVE FULL CONTROL OVER STATE OF VIEW
abstract base class BaseViewModel with _BaseViewModelMixin, _BaseViewModelStateMixin {
  /// Called when View is created
  @mustCallSuper
  void onInit() {
    _assertStateBuilderInitialized();
    Dock
      ..addPostFrameCallback(onPostFrame)
      ..scheduleFrameCallback(onNextFrame);
  }

  /// Called after onInit and when dependencies of this object change
  @mustCallSuper
  void onDependenciesChange() {
    _assertStateBuilderInitialized();
  }

  /// Called at the end of the first frame of page render.
  ///
  /// Handle network requests, navigation etc. here
  @mustCallSuper
  @protected
  @visibleForTesting
  void onPostFrame(Duration timeStamp) {
    _assertStateBuilderInitialized();
  }

  /// Called at the beginning of the second frame of page render
  @mustCallSuper
  @protected
  @visibleForTesting
  void onNextFrame(Duration timeStamp) {
    _assertStateBuilderInitialized();
  }

  /// Called when view is getting disposed
  @mustCallSuper
  void onDispose() {
    _assertStateBuilderInitialized();
  }
}
