import 'package:dock_flutter/dock.dart';

extension LoaderAndOverlayExtension on BaseViewModel {
  PopupManager get rootPopupManager => Locator.find<PopupManager>();

  OverlayManager get rootOverlayManager => Locator.find<OverlayManager>();
}
