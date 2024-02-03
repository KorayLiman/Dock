part of '../../../../core/base/viewmodel/base_viewmodel.dart';

/// A [StatelessElement] of Docker to update it's [Widget]
final class DockerStatelessElement extends StatelessElement {
  DockerStatelessElement(super.widget);

  Docker get dockerWidget => widget as Docker;
  Map<Object, DockerUpdater>? dockerUpdaters;

  @override
  void mount(Element? parent, Object? newSlot) {
    dockerWidget.vModel._dockerUpdaters ??= {};
    dockerUpdaters = dockerWidget.vModel._dockerUpdaters;

    dockerUpdaters![dockerWidget.id] = updateElement;

    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    assert(dockerUpdaters.isNotNull, 'Tried to unmount() $runtimeType already unmounted');
    dockerUpdaters!.remove(dockerWidget.id);
    if (dockerUpdaters!.isEmpty) {
      dockerUpdaters = null;
      dockerWidget.vModel._dockerUpdaters = null;
    }
    super.unmount();
  }

  /// Schedules widget to rebuilt in the next frame
  void updateElement() {
    assert(dockerUpdaters.isNotNull, "You called update() method on Docker doesn't exist or disposed");
    if (dockerWidget.vModel._containsDockerUpdater(id: dockerWidget.id)) {
      Dock.safeMarkNeedsBuild(this);
    }
  }
}
