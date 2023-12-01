import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:dock_flutter_example/product/components/appbars/appbars.dart';
import 'package:dock_flutter_example/product/enums/route_paths.dart';
import 'package:dock_flutter_example/product/extensions/route_paths_extensions/route_paths_extension.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class LoginView extends BaseView<LoginViewModel> {
  LoginView({super.arguments}) : super(viewModel: LoginViewModel(), key: ValueKey<String>(RoutePaths.login.rawValue));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<LoginViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => const LoginViewSuccessWidget(),
    );
  }
}

class _LoginViewFloatingActionButton extends DockAccess<LoginViewModel> {
  const _LoginViewFloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: '0',
          onPressed: viewModel.showCustomOverlay,
          label: const Text('Show custom overlay'),
          icon: const Icon(Icons.info_outline),
        ),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton.extended(
          heroTag: '1',
          onPressed: viewModel.showDefaultToast,
          label: const Text('Show default toast'),
          icon: const Icon(Icons.info_outline),
        ),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton.extended(
          heroTag: '2',
          onPressed: viewModel.showAndHideLoader,
          label: const Text('Show loader'),
          icon: const Icon(Icons.refresh),
        ),
      ],
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
        label: const Text('Login'),
        icon: const Icon(Icons.navigate_next),
      ),
    );
  }
}

class LoginViewSuccessWidget extends StatelessWidget {
  const LoginViewSuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Login',
      ),
      body: _LoginViewBody(),
      floatingActionButton: _LoginViewFloatingActionButton(),
    );
  }
}
