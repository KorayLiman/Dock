import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/product/utils/logger.dart';

class CustomNavigationObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _setOverlayStateOnPush(route, previousRoute);
    if (!_isDialogOrModalBottomSheetRoute(route)) {
      Logger.logMsg(msg: '---> Pushed Route: (${route.data?.name})  &  Previous: (${previousRoute?.data?.name})', color: LogColors.magenta);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _setOverlayStateOnPop(route, previousRoute);
    if (!_isDialogOrModalBottomSheetRoute(route)) {
      Logger.logMsg(msg: '<--- Popped To:  (${previousRoute?.data?.name})  &  Previous: (${route.data?.name})', color: LogColors.cyan);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _setOverlayStateOnRemove(route, previousRoute);
    Logger.logMsg(msg: 'Removed Route:  ${route.data?.name}', color: LogColors.red);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    Logger.logMsg(msg: 'Tab Changed:  Previous: ${previousRoute.name}  ~  Current: ${route.name}', color: LogColors.magenta);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    Logger.logMsg(msg: 'Init Tab Route: ${route.name}', color: LogColors.magenta);
  }

  void _setOverlayStateOnPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    route is DialogRoute ? _isDialogOpen = true : _isDialogOpen = false;
    route is ModalBottomSheetRoute ? _isModalBottomSheetOpen = true : _isModalBottomSheetOpen = false;
  }

  void _setOverlayStateOnPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    previousRoute is DialogRoute ? _isDialogOpen = true : _isDialogOpen = false;
    previousRoute is ModalBottomSheetRoute ? _isModalBottomSheetOpen = true : _isModalBottomSheetOpen = false;
  }

  void _setOverlayStateOnRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    previousRoute is DialogRoute ? _isDialogOpen = true : _isDialogOpen = false;
    previousRoute is ModalBottomSheetRoute ? _isModalBottomSheetOpen = true : _isModalBottomSheetOpen = false;
  }

  bool _isDialogOpen = false;
  bool _isModalBottomSheetOpen = false;

  bool get isDialogOpen => _isDialogOpen;

  bool get isModalBottomSheetOpen => _isModalBottomSheetOpen;

  bool _isDialogOrModalBottomSheetRoute(Route<dynamic> route) => route is DialogRoute || route is ModalBottomSheetRoute;
}
