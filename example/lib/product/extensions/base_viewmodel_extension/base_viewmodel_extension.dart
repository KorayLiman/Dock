import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/core.dart';

extension LoaderAndOverlayExtension on BaseViewModel {
  PopupManager get rootPopupManager => Locator.find<PopupManager>();

  OverlayManager get rootOverlayManager => Locator.find<OverlayManager>();
}

extension NavigationExtension on BaseViewModel {
  AppRouter get rootRouter => AppRouter.find;
}
