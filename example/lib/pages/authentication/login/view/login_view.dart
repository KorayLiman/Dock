import 'package:auto_route/auto_route.dart';
import 'package:dock/core/base/view/base_view.dart';
import 'package:dock/core/widget/dock_access_widget/dock_access_widget.dart';
import 'package:dock/core/widget/dock_builder/dock_builder.dart';
import 'package:dock_example/pages/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:dock_example/product/components/appbars/appbars.dart';
import 'package:dock_example/product/enums/route_paths.dart';
import 'package:dock_example/product/extensions/route_paths_extensions/route_paths_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class LoginView extends BaseView<LoginViewModel> {
  LoginView({super.arguments}) : super(viewModel: LoginViewModel(), key: ValueKey<String>(RoutePaths.login.rawValue));

  @override
  DockBuilder build(BuildContext context) {
    return DockBuilder(
      viewModel: viewModel,
      onSuccess: () => const Scaffold(
        appBar: DefaultAppBar(
          title: 'Login',
        ),
        body: _LoginViewBody(),
        floatingActionButton: _LoginViewFloatingActionButton(),
      ),
    );
  }
}

class _LoginViewFloatingActionButton extends DockAccess<LoginViewModel> {
  const _LoginViewFloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: viewModel.showAndHideLoader,
      label: const Text('Show loader'),
      icon: const Icon(Icons.refresh),
    );
  }
}

class _LoginViewBody extends DockAccess<LoginViewModel> {
  const _LoginViewBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: viewModel.goToHomePage,
        label: const Text('Navigate to Home'),
        icon: const Icon(Icons.navigate_next),
      ),
    );
  }
}
