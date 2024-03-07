import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/presentation/authentication/login/viewmodel/login_viewmodel.dart';
import 'package:dock_flutter_example/product/product.dart';
import 'package:flutter/material.dart';

final class LoginView extends BaseView<LoginViewModel> {
  const LoginView({required super.viewModelCallback, super.key});

  @override
  Widget onSuccess(BuildContext context, LoginViewModel viewModel) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Login',
      ),
      body: LoginViewBody._(),
      floatingActionButton: LoginViewFloatingActionButton._(),
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
        const Gap(12),
        FloatingActionButton.extended(
          heroTag: '2',
          onPressed: viewModel.showAndHideLoader,
          label: const Text('Show loader'),
          icon: const Icon(Icons.refresh),
        ),
        const Gap(12),
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
            width: context.dependOn.width * 0.7,
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
