enum RoutePaths {
  splash('/splash'),
  login('/login'),
  homeTab('/homeTab'),
  homeMainChild('homeMainChild'),
  homeListChild('homeMainList'),
  homeSettingsChild('homeMainSettings');

  const RoutePaths(this.path);

  final String path;
}
