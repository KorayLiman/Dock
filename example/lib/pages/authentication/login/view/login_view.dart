import 'package:auto_route/auto_route.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/pages/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

@RoutePage()
final class LoginView extends BaseView<LoginViewModel> {
  LoginView({super.arguments}) : super(viewModel: LoginViewModel(), key: const AutomationKey(Automation.loginView));

  @override
  StateBuilder build(BuildContext context) {
    return StateBuilder<LoginViewModel>(
      viewModel: viewModel,
      onSuccess: (context) => const LoginViewOnSuccessWidget._(),
    );
  }
}

class LoginViewFloatingActionButton extends DockStatelessWidget<LoginViewModel> {
  const LoginViewFloatingActionButton._();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          heroTag: '1',
          onPressed: viewModel.showToast,
          label: const Text('Show toast'),
          icon: const Icon(Icons.info_outline),
        ),
        verticalMargin12,
        FloatingActionButton.extended(
          heroTag: '2',
          onPressed: viewModel.showAndHideLoader,
          label: const Text('Show loader'),
          icon: const Icon(Icons.refresh),
        ),
        verticalMargin12,
        FloatingActionButton.extended(
          heroTag: '3',
          onPressed: viewModel.login,
          label: const Text('Login'),
          icon: const Icon(Icons.login),
        ),
      ],
    );
  }
}

class LoginViewBody extends DockStatelessWidget<LoginViewModel> {
  const LoginViewBody._();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: context.width * 0.7,
            child: const Row(
              children: [
                Expanded(
                  child: AutoSizedText(
                    'This is a very long text that should be shrinked to fit the screen',
                    maxLines: 3,
                    style: TextStyle(fontSize: 150),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: viewModel.goToHomePage,
            label: const Text('Login'),
            icon: const Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}

class LoginViewOnSuccessWidget extends StatelessWidget {
  const LoginViewOnSuccessWidget._();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Login',
      ),
      body: LoginViewBody._(),
      floatingActionButton: LoginViewFloatingActionButton._(),
    );
  }
}
