import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/parent/home_tab_parent/viewmodel/home_tab_parent_viewmodel.dart';
import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

final class HomeTabParentView extends BaseView<HomeTabParentViewModel> {
  HomeTabParentView({super.key})
      : super(
          viewModel: Locator.register(HomeTabParentViewModel()),
        );

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<HomeTabParentViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => const HomeTabParentOnSuccessWidget._(),
    );
  }
}

class HomeTabParentOnSuccessWidget extends DockStatelessWidget<HomeTabParentViewModel> {
  const HomeTabParentOnSuccessWidget._();

  @override
  Widget build(BuildContext context) {
    return TabsBuilder(
      builder: (context, router, state) {
        return Scaffold(
          body: router,
          bottomNavigationBar: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Main'),
              NavigationDestination(icon: Icon(Icons.list), label: 'List'),
              NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
            ],
            selectedIndex: state.activeTabIndex,
            onDestinationSelected: state.setActiveIndex,
          ),
        );
      },
    );
  }
}
