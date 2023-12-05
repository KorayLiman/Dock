import 'package:dock_flutter_example/product/enums/route_paths/route_paths.dart';

extension RoutePathExtension on RoutePaths {
  String get rawValue => switch (this) {
        RoutePaths.splash => '/splash',
        RoutePaths.login => '/login',
        RoutePaths.homeTab => '/homeTab',
        RoutePaths.homeMainChild => 'homeMainChild',
        RoutePaths.homeListChild => 'homeMainList',
        RoutePaths.homeSettingsChild => 'homeMainSettings',
      };
}
