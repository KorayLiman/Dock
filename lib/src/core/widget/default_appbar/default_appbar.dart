part of '../../base/viewmodel/base_viewmodel.dart';

/// DEFAULT [AppBar] of PageState
class _DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _DefaultAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
