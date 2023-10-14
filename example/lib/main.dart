import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/navigation/navigation_observer/navigation_observer.dart';
import 'package:dock_flutter_example/product/constants/app_constants.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = Locator.isRegistered<AppRouter>()
        ? Locator.find<AppRouter>()
        : Locator.register<AppRouter>(
            AppRouter(),
          );

    return MaterialApp.router(
      routerConfig: appRouter.config(
        navigatorObservers: () => [
          if (Locator.isRegistered<CustomNavigationObserver>())
            Locator.find<CustomNavigationObserver>()
          else
            Locator.register<CustomNavigationObserver>(
              CustomNavigationObserver(),
            ),
        ],
      ),
      theme: AppConstants.themeConstants.material3,
    );
  }
}
