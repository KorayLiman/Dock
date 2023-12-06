import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/core.dart';

extension LoaderAndOverlayExtension on BaseViewModel {
  LoaderManager get rootLoaderManager => LoaderManager(rootRouter.navigatorKey);

  OverlayManager get rootOverlayManager => OverlayManager(rootRouter.navigatorKey);
}

extension NavigationExtension on BaseViewModel {
  AppRouter get rootRouter => AppRouter.find;
}
