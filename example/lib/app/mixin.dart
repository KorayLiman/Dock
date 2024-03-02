part of '../main.dart';

mixin class _AppMixin {
  ThemeData get theme {
    return AppConstants.themeConstants.light;
  }

  /// ScaffoldMessengerStateKey
  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey {
    return AppKeys.stateKeys.rootScaffoldMessengerStateKey;
  }
}
