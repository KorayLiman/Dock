import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/general/home_tab/parent/home_tab_parent/viewmodel/home_tab_parent_viewmodel.dart';
import 'package:dock_router/dock_router.dart';
import 'package:flutter/material.dart';

final class HomeTabParentView extends BaseView<HomeTabParentViewModel> {
  const HomeTabParentView({required super.viewModelCallback, super.key});

  @override
  Widget onSuccess(BuildContext context, HomeTabParentViewModel viewModel) {
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
            selectedIndex: state.activeIndex,
            onDestinationSelected: state.setActiveIndex,
          ),
        );
      },
    );
  }
}
