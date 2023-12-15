part of '../main.dart';

mixin class _AppMixin {
  /// [AppRouter]
  AppRouter get appRouter {
    return Locator.isRegistered<AppRouter>()
        ? Locator.find<AppRouter>()
        : Locator.register<AppRouter>(
            AppRouter.create(),
          );
  }

  /// [Router] Config
  RouterConfig<UrlState> get routerConfig {
    return appRouter.config(
      navigatorObservers: navigatorObservers,
    );
  }

  ThemeData get theme {
    return AppConstants.themeConstants.light;
  }

  /// [Navigator] Observers
  List<NavigatorObserver> navigatorObservers() {
    return [
      if (Locator.isRegistered<CustomNavigationObserver>())
        Locator.find<CustomNavigationObserver>()
      else
        Locator.register<CustomNavigationObserver>(
          CustomNavigationObserver(),
        ),
    ];
  }

  /// ScaffoldMessengerKey
  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey {
    return Locator.register<GlobalKey<ScaffoldMessengerState>>(
      GlobalKey<ScaffoldMessengerState>(),
    );
  }
}
