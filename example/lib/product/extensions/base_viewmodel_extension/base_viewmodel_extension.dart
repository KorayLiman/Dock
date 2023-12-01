import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';

extension LoaderAndOverlayExtension on BaseViewModel {
  LoaderManager get rootLoaderManager => LoaderManager(router.navigatorKey);

  OverlayManager get rootOverlayManager => OverlayManager(router.navigatorKey);
}

extension NavigationExtension on BaseViewModel {
  AppRouter get router => AppRouter.find;
}
