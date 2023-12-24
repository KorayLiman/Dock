part of '../main.dart';

final class DockApp extends StatelessWidget with _AppMixin {
  @visibleForTesting
  const DockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      theme: theme,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
