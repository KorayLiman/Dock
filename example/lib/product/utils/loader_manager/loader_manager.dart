// ignore_for_file: prefer_constructors_over_static_methods
import 'package:flutter/material.dart';
import 'package:liman/product/extensions/extensions.dart';
import 'package:liman/product/utils/logger.dart';
import 'package:liman_example/core/navigation/app_router/app_router.dart';
import 'package:liman_example/core/navigation/app_router/app_router.gr.dart';
import 'package:liman_example/product/enums/route_paths.dart';
import 'package:liman_example/product/extensions/route_names_extensions/route_names_extension.dart';

abstract class LoaderManager {
  static List<Key>? _widgetKeys;

  static void show({Key? key}) {
    final keyParam = key ?? UniqueKey();
    _widgetKeys ??= <Key>[];
    _widgetKeys!.add(keyParam);
    AppRouter.find.push(LoaderOverlayRoute(key: key));
  }

  static void hide({Key? key}) {
    if (_widgetKeys.isNullOrEmpty) {
      Logger.logMsg(
        msg: '//\n**Error while closing loader: There is no loader to close**\n//',
        color: LogColors.red,
      );
      return;
    }
    if (key.isNotNull) {
      if (_widgetKeys.notContains(key)) {
        Logger.logMsg(
          msg: '//\n**Error while closing loader: There is no loader with key $key**\n//',
          color: LogColors.red,
        );
        return;
      }
      final result = AppRouter.find.removeWhere((route) => route.path == RoutePaths.loaderDialog.rawValue && route.argsAs<LoaderOverlayRouteArgs>().key == key);
      if (result) {
        _widgetKeys!.remove(key);
        if (_widgetKeys!.isEmpty) {
          _widgetKeys = null;
        }
      } else {
        Logger.logMsg(
          msg: '//\n**Error while closing loader: ${RoutePaths.loaderDialog.rawValue}**\n//',
          color: LogColors.red,
        );
      }
      return;
    }
    final result = AppRouter.find.removeWhere((route) => route.path == RoutePaths.loaderDialog.rawValue && route.argsAs<LoaderOverlayRouteArgs>().key == _widgetKeys!.last);
    if (result) {
      _widgetKeys!.removeLast();
      if (_widgetKeys!.isEmpty) {
        _widgetKeys = null;
      }
    } else {
      Logger.logMsg(
        msg: '//\n**Error while closing loader: ${RoutePaths.loaderDialog.rawValue}**\n//',
        color: LogColors.red,
      );
    }
  }
}
