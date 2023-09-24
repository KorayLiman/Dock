import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liman/core/base/view/base_view.dart';
import 'package:liman/core/widget/registrar_widget/registrar_widget.dart';
import 'package:liman_example/pages/general/home/viewmodel/home_viewmodel.dart';
import 'package:liman_example/product/components/appbars/appbars.dart';
import 'package:liman_example/product/enums/route_paths.dart';
import 'package:liman_example/product/extensions/route_names_extensions/route_names_extension.dart';

@RoutePage()
final class HomeView extends RegistrarWidget<HomeViewModel> {
  HomeView({super.arguments}) : super(viewModel: HomeViewModel(), key: ValueKey<String>(RoutePaths.home.rawValue));

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: viewModel,
      onSuccess: () => _onSuccess(context: context),
    );
  }

  Widget _onSuccess({required BuildContext context}) {
    return const Scaffold(
      appBar: DefaultAutoRouteAppBar(
        title: 'Home',
      ),
    );
  }
}
