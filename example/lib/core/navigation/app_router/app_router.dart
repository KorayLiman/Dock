import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/core/navigation/navigation_observer/navigation_observer.dart';
import 'package:dock_flutter_example/product/enums/route_paths/route_paths.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
final class AppRouter extends $AppRouter {
  AppRouter.create();

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          path: RoutePaths.splash.path,
          initial: true,
        ),
        AutoRoute(
          page: LoginRoute.page,
          path: RoutePaths.login.path,
        ),
        AutoRoute(
          page: HomeTabParentRoute.page,
          path: RoutePaths.homeTab.path,
          children: [
            AutoRoute(
              page: HomeMainChildRoute.page,
              path: RoutePaths.homeMainChild.path,
            ),
            AutoRoute(
              page: HomeListChildRoute.page,
              path: RoutePaths.homeListChild.path,
            ),
            AutoRoute(
              page: HomeSettingsChildRoute.page,
              path: RoutePaths.homeSettingsChild.path,
            ),
          ],
        ),
      ];

  /// Finds [AppRouter]
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

  /// CLOSES MODAL BOTTOM SHEETS UNTIL TOP MOST ROUTE IS NOT MODAL BOTTOM SHEET ROUTE ANYMORE
  Future<void> closeAllModalBottomSheetsOnTop() async {
    while (isTopRouteModalBottomSheet) {
      await pop();
    }
  }
}
