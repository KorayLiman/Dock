import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key, this.title, this.centerTitle = true});

  final String? title;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DefaultAutoRouteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAutoRouteAppBar({super.key, this.title, this.centerTitle = true});

  final String? title;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AutoLeadingButton(
        ignorePagelessRoutes: true,
      ),
      title: title != null ? Text(title!) : null,
      centerTitle: centerTitle,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
