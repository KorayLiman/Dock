import 'package:flutter/material.dart';
import 'package:liman/core/locator/locator.dart';
import 'package:liman_example/core/navigation/app_router/app_router.dart';
import 'package:liman_example/core/navigation/navigation_observer/navigation_observer.dart';
import 'package:liman_example/product/constants/app_constants.dart';

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
