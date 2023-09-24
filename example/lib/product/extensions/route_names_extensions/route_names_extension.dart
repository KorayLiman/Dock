import 'package:liman_example/product/enums/route_paths.dart';

extension RouteNamesExtension on RoutePaths {
  String get rawValue => switch (this) {
        RoutePaths.splash => '/splash',
        RoutePaths.login => '/login',
        RoutePaths.loaderDialog => '/loaderOverlay',
        RoutePaths.home => '/home',
      };
}
