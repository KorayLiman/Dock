// ignore_for_file: prefer_constructors_over_static_methods

import 'package:dio/dio.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/env/env.dart';
import 'package:dock_flutter_example/product/constants/constants.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';

final class NetworkManager {
  NetworkManager._() {
    coreDio = CoreDio(
      baseOptions: BaseOptions(
        baseUrl: AppConstants.appBuildType.type == BuildType.test ? Env.testBaseUrl : Env.liveBaseUrl,
      ),
    );
  }

  late final CoreDio coreDio;

  static NetworkManager? _instance;

  static NetworkManager get instance => _instance ??= NetworkManager._();
}
