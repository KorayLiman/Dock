part of '../main.dart';

final rootRouter = DockRouter(
  routes: () => [
    RouteConfiguration(
      initial: true,
      name: RouteNames.splash.name,
      builder: (context) => SplashView(viewModelCallback: () => Locator.register(SplashViewModel())),
    ),
    RouteConfiguration(
      name: RouteNames.login.name,
      builder: (context) {
        return LoginView(viewModelCallback: () => Locator.register(LoginViewModel()));
      },
    ),
    RouteConfiguration(
      name: RouteNames.homeTab.name,
      builder: (context) => HomeTabParentView(viewModelCallback: () => Locator.register(HomeTabParentViewModel())),
      children: [
        RouteConfiguration.tab(
          name: RouteNames.homeMainChild.name,
          tabIndex: 0,
          builder: (context) => const HomeMainChildView(
            viewModelCallback: HomeMainChildViewModel.new,
          ),
        ),
        RouteConfiguration.tab(
          name: RouteNames.homeListChild.name,
          tabIndex: 1,
          builder: (context) => const HomeListChildView(viewModelCallback: HomeListChildViewModel.new),
        ),
        RouteConfiguration.tab(
          name: RouteNames.homeSettingsChild.name,
          tabIndex: 2,
          builder: (context) => const HomeSettingsChildView(viewModelCallback: HomeSettingsChildViewModel.new),
        ),
      ],
    ),
  ],
);
