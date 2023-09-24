import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/access_widget/access_widget.dart';
import 'package:liman/core/widget/registrar_widget/registrar_widget.dart';
import 'package:liman_example/pages/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:liman_example/product/components/appbars/appbars.dart';
import 'package:liman_example/product/enums/route_paths.dart';
import 'package:liman_example/product/extensions/route_names_extensions/route_names_extension.dart';

@RoutePage()
final class LoginView extends RegistrarWidget<LoginViewModel> {
  LoginView({super.arguments}) : super(viewModel: LoginViewModel(), key: ValueKey<String>(RoutePaths.login.rawValue));

  @override
  Widget build(BuildContext context) {
    return BaseView(
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

class _LoginViewFloatingActionButton extends AccessWidget<LoginViewModel> {
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

class _LoginViewBody extends AccessWidget<LoginViewModel> {
  const _LoginViewBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          await viewModel.goToHomePage(context: context);
        },
        label: const Text('Navigate to Home'),
        icon: const Icon(Icons.navigate_next),
      ),
    );
  }
}
