import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.gr.dart';
import 'package:dock_flutter_example/pages/general/home_tab/parent/home_tab_parent/viewmodel/home_tab_parent_viewmodel.dart';
import 'package:dock_flutter_example/product/enums/route_paths.dart';
import 'package:dock_flutter_example/product/extensions/route_paths_extensions/route_paths_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class HomeTabParentView extends BaseView<HomeTabParentViewModel> {
  HomeTabParentView({super.arguments}) : super(viewModel: HomeTabParentViewModel(), key: ValueKey<String>(RoutePaths.homeTab.rawValue));

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
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
