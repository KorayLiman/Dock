import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/core/navigation/navigation_observer/navigation_observer.dart';
import 'package:dock_flutter_example/product/enums/route_paths.dart';
import 'package:dock_flutter_example/product/extensions/route_paths_extensions/route_paths_extension.dart';
import 'package:flutter/material.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends $AppRouter {
  AppRouter._();

  // ignore: prefer_constructors_over_static_methods
  static AppRouter create() => AppRouter._();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: RoutePaths.splash.rawValue,
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: RoutePaths.login.rawValue,
        ),
        AutoRoute(
          page: HomeTabParentRoute.page,
          path: RoutePaths.homeTab.rawValue,
          children: [
            AutoRoute(
              page: HomeMainChildRoute.page,
              path: RoutePaths.homeMainChild.rawValue,
            ),
            AutoRoute(
              page: HomeListChildRoute.page,
              path: RoutePaths.homeListChild.rawValue,
            ),
            AutoRoute(
              page: HomeSettingsChildRoute.page,
              path: RoutePaths.homeSettingsChild.rawValue,
            ),
          ],
        ),
        // DIALOGS
        CustomRoute(
          page: LoaderOverlayRoute.page,
          path: RoutePaths.loaderDialog.rawValue,
          fullscreenDialog: true,
          barrierDismissible: false,
          barrierColor: Colors.grey.shade300.withOpacity(0.6),
          opaque: false,
        ),
      ];

  /// Locates AppRouter
  static AppRouter get find => Locator.find<AppRouter>();

  CustomNavigationObserver get _navigationObserver => Locator.find<CustomNavigationObserver>();

  ///////// UTILS ////////////

  /// CHECKS IF TOP ROUTE IS DIALOG ROUTE
  bool get isTopRouteDialog => _navigationObserver.isDialogOpen;

  /// CHECKS IF TOP ROUTE IS MODAL BOTTOM SHEET ROUTE
  ///
  /// !!CAUTION!! SINCE "showBottomSheet" doesn't push a new route to stack
  /// this only returns proper result for "showModalBottomSheet"
  bool get isTopRouteModalBottomSheet => _navigationObserver.isModalBottomSheetOpen;

  /// CLOSES DIALOGS UNTIL TOP MOST ROUTE IS NOT DIALOG ROUTE
  Future<void> closeAllDialogsOnTop() async {
    while (isTopRouteDialog) {
      await pop();
    }
  }

  /// CLOSES MODAL BOTTOM SHEETS UNTIL TOP MOST ROUTE IS NOT MODAL BOTTOM SHEET ROUTE
  Future<void> closeAllModalBottomSheetsOnTop() async {
    while (isTopRouteModalBottomSheet) {
      await pop();
    }
  }
}
