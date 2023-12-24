// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:dock_flutter_example/pages/authentication/login/view/login_view.dart'
    as _i5;
import 'package:dock_flutter_example/pages/general/home_tab/children/home_list_child/view/home_list_child_view.dart'
    as _i1;
import 'package:dock_flutter_example/pages/general/home_tab/children/home_main_child/view/home_main_child_view.dart'
    as _i2;
import 'package:dock_flutter_example/pages/general/home_tab/children/home_settings_child/view/home_settings_child_view.dart'
    as _i3;
import 'package:dock_flutter_example/pages/general/home_tab/parent/home_tab_parent/view/home_tab_parent_view.dart'
    as _i4;
import 'package:dock_flutter_example/pages/launch/splash/view/splash_view.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeListChildRoute.name: (routeData) {
      final args = routeData.argsAs<HomeListChildRouteArgs>(
          orElse: () => const HomeListChildRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeListChildView(arguments: args.arguments),
      );
    },
    HomeMainChildRoute.name: (routeData) {
      final args = routeData.argsAs<HomeMainChildRouteArgs>(
          orElse: () => const HomeMainChildRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.HomeMainChildView(arguments: args.arguments),
      );
    },
    HomeSettingsChildRoute.name: (routeData) {
      final args = routeData.argsAs<HomeSettingsChildRouteArgs>(
          orElse: () => const HomeSettingsChildRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.HomeSettingsChildView(arguments: args.arguments),
      );
    },
    HomeTabParentRoute.name: (routeData) {
      final args = routeData.argsAs<HomeTabParentRouteArgs>(
          orElse: () => const HomeTabParentRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.HomeTabParentView(arguments: args.arguments),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.LoginView(arguments: args.arguments),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.SplashView(arguments: args.arguments),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeListChildView]
class HomeListChildRoute extends _i7.PageRouteInfo<HomeListChildRouteArgs> {
  HomeListChildRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomeListChildRoute.name,
          args: HomeListChildRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'HomeListChildRoute';

  static const _i7.PageInfo<HomeListChildRouteArgs> page =
      _i7.PageInfo<HomeListChildRouteArgs>(name);
}

class HomeListChildRouteArgs {
  const HomeListChildRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'HomeListChildRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i2.HomeMainChildView]
class HomeMainChildRoute extends _i7.PageRouteInfo<HomeMainChildRouteArgs> {
  HomeMainChildRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomeMainChildRoute.name,
          args: HomeMainChildRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'HomeMainChildRoute';

  static const _i7.PageInfo<HomeMainChildRouteArgs> page =
      _i7.PageInfo<HomeMainChildRouteArgs>(name);
}

class HomeMainChildRouteArgs {
  const HomeMainChildRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'HomeMainChildRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i3.HomeSettingsChildView]
class HomeSettingsChildRoute
    extends _i7.PageRouteInfo<HomeSettingsChildRouteArgs> {
  HomeSettingsChildRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomeSettingsChildRoute.name,
          args: HomeSettingsChildRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'HomeSettingsChildRoute';

  static const _i7.PageInfo<HomeSettingsChildRouteArgs> page =
      _i7.PageInfo<HomeSettingsChildRouteArgs>(name);
}

class HomeSettingsChildRouteArgs {
  const HomeSettingsChildRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'HomeSettingsChildRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i4.HomeTabParentView]
class HomeTabParentRoute extends _i7.PageRouteInfo<HomeTabParentRouteArgs> {
  HomeTabParentRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          HomeTabParentRoute.name,
          args: HomeTabParentRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'HomeTabParentRoute';

  static const _i7.PageInfo<HomeTabParentRouteArgs> page =
      _i7.PageInfo<HomeTabParentRouteArgs>(name);
}

class HomeTabParentRouteArgs {
  const HomeTabParentRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'HomeTabParentRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i5.LoginView]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<LoginRouteArgs> page =
      _i7.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'LoginRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i6.SplashView]
class SplashRoute extends _i7.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    dynamic arguments,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i7.PageInfo<SplashRouteArgs> page =
      _i7.PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'SplashRouteArgs{arguments: $arguments}';
  }
}
