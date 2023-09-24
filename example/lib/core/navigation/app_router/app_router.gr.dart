// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:liman_example/pages/authentication/login/view/login_view.dart'
    as _i3;
import 'package:liman_example/pages/general/home/view/home_view.dart' as _i1;
import 'package:liman_example/pages/launch/splash/view/splash_view.dart' as _i4;
import 'package:liman_example/product/components/loader_overlay/loader_overlay.dart'
    as _i2;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomeView(arguments: args.arguments),
      );
    },
    LoaderOverlayRoute.name: (routeData) {
      final args = routeData.argsAs<LoaderOverlayRouteArgs>(
          orElse: () => const LoaderOverlayRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LoaderDialog(
          key: args.key,
          loader: args.loader,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.LoginView(arguments: args.arguments),
      );
    },
    SplashRoute.name: (routeData) {
      final args = routeData.argsAs<SplashRouteArgs>(
          orElse: () => const SplashRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.SplashView(arguments: args.arguments),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeView]
class HomeRoute extends _i5.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    dynamic arguments,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<HomeRouteArgs> page =
      _i5.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'HomeRouteArgs{arguments: $arguments}';
  }
}

/// generated route for
/// [_i2.LoaderDialog]
class LoaderOverlayRoute extends _i5.PageRouteInfo<LoaderOverlayRouteArgs> {
  LoaderOverlayRoute({
    _i6.Key? key,
    _i6.Widget? loader,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoaderOverlayRoute.name,
          args: LoaderOverlayRouteArgs(
            key: key,
            loader: loader,
          ),
          initialChildren: children,
        );

  static const String name = 'LoaderOverlayRoute';

  static const _i5.PageInfo<LoaderOverlayRouteArgs> page =
      _i5.PageInfo<LoaderOverlayRouteArgs>(name);
}

class LoaderOverlayRouteArgs {
  const LoaderOverlayRouteArgs({
    this.key,
    this.loader,
  });

  final _i6.Key? key;

  final _i6.Widget? loader;

  @override
  String toString() {
    return 'LoaderOverlayRouteArgs{key: $key, loader: $loader}';
  }
}

/// generated route for
/// [_i3.LoginView]
class LoginRoute extends _i5.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    dynamic arguments,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<LoginRouteArgs> page =
      _i5.PageInfo<LoginRouteArgs>(name);
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
/// [_i4.SplashView]
class SplashRoute extends _i5.PageRouteInfo<SplashRouteArgs> {
  SplashRoute({
    dynamic arguments,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          SplashRoute.name,
          args: SplashRouteArgs(arguments: arguments),
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i5.PageInfo<SplashRouteArgs> page =
      _i5.PageInfo<SplashRouteArgs>(name);
}

class SplashRouteArgs {
  const SplashRouteArgs({this.arguments});

  final dynamic arguments;

  @override
  String toString() {
    return 'SplashRouteArgs{arguments: $arguments}';
  }
}
