import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/pages/general/home_tab/parent/home_tab_parent/viewmodel/home_tab_parent_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeTabParentView extends BaseView<HomeTabParentViewModel> {
  HomeTabParentView({super.arguments}) : super(viewModel: HomeTabParentViewModel(), key: const AutomationKey(Automation.homeTabParentView));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeTabParentViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => const HomeTabParentOnSuccessWidget(),
    );
  }
}

class HomeTabParentOnSuccessWidget extends StatelessWidget {
  @visibleForTesting
  const HomeTabParentOnSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [
        HomeMainChildRoute(),
        HomeListChildRoute(),
        HomeSettingsChildRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Main'),
              NavigationDestination(icon: Icon(Icons.list), label: 'List'),
              NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            ],
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
          ),
        );
      },
    );
  }
}
