import 'package:liman_example/product/enums/route_paths.dart';

extension RoutePathsExtension on RoutePaths {
  String get rawValue => switch (this) {
        RoutePaths.splash => '/splash',
        RoutePaths.login => '/login',
        RoutePaths.loaderDialog => '/loaderOverlay',
        RoutePaths.homeTab => '/homeTab',
        RoutePaths.homeMainChild => 'homeMainChild',
        RoutePaths.homeListChild => 'homeMainList',
        RoutePaths.homeSettingsChild => 'homeMainSettings',
      };
}
