part of '../main.dart';

final rootRouter = DockRouter(
  routes: () => [
    RouteConfiguration(
      initial: true,
      name: RouteNames.splash.name,
      builder: (context) => SplashView(),
    ),
    RouteConfiguration(
      name: RouteNames.login.name,
      builder: (context) {
        return LoginView();
      },
    ),
    RouteConfiguration(
      name: RouteNames.homeTab.name,
      builder: (context) => HomeTabParentView(),
      children: [
        RouteConfiguration.tab(
          name: RouteNames.homeMainChild.name,
          tabIndex: 0,
          builder: (context) => HomeMainChildView(),
        ),
        RouteConfiguration.tab(
          name: RouteNames.homeListChild.name,
          tabIndex: 1,
          builder: (context) => HomeListChildView(),
        ),
        RouteConfiguration.tab(
          name: RouteNames.homeSettingsChild.name,
          tabIndex: 2,
          builder: (context) => HomeSettingsChildView(),
        ),
      ],
    ),
  ],
);
