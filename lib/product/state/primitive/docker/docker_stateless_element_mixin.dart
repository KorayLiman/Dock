part of '../../../../core/base/viewmodel/base_viewmodel.dart';

/// A mixin on [StatelessElement] for primitive (manual) update
mixin DockerStatelessElementMixin on StatelessElement {
  Docker get dockerWidget => widget as Docker;
  Map<String, DockerUpdater>? dockerUpdaters;

  @override
  void mount(Element? parent, Object? newSlot) {
    dockerWidget.viewModel._dockerUpdaters ??= {};
    dockerUpdaters = dockerWidget.viewModel._dockerUpdaters;

    dockerUpdaters![dockerWidget.id] = updateElement;

    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    assert(dockerUpdaters.isNotNull, 'Tried to unmount() $runtimeType already unmounted');
    dockerUpdaters!.remove(dockerWidget.id);
    if (dockerUpdaters!.isEmpty) {
      dockerUpdaters = null;
      dockerWidget.viewModel._dockerUpdaters = null;
    }
    super.unmount();
  }

  /// Schedules widget to rebuilt in the next frame
  void updateElement() {
    assert(dockerUpdaters.isNotNull, "You called update() method on Docker doesn't exist or disposed");
    if (dockerWidget.viewModel._containsDockerUpdater(id: dockerWidget.id)) {
      final schedulerPhase = SchedulerBinding.instance.schedulerPhase;
      if (schedulerPhase == SchedulerPhase.idle || schedulerPhase == SchedulerPhase.postFrameCallbacks) {
        markNeedsBuild();
      } else {
        scheduleMicrotask(markNeedsBuild);
      }
    }
  }
}
