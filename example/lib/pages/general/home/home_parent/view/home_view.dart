import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/dock_builder/dock_builder.dart';
import 'package:liman_example/core/navigation/app_router/app_router.gr.dart';
import 'package:liman_example/pages/general/home/home_parent/viewmodel/home_viewmodel.dart';
import 'package:liman_example/product/enums/route_paths.dart';
import 'package:liman_example/product/extensions/route_paths_extensions/route_paths_extension.dart';

@RoutePage()
final class HomeView extends BaseView<HomeViewModel> {
  HomeView({super.arguments}) : super(viewModel: HomeViewModel(), key: ValueKey<String>(RoutePaths.home.rawValue));

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
