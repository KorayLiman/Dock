import 'package:dio/dio.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:flutter/material.dart';

abstract base class BaseService {
  BaseService(this._networkManager);

  late final NetworkManager _networkManager;

  Future<BaseResponse<T>> request<T, M extends BaseModel<dynamic>>({
    required RequestPath path,
    required RequestType type,
    required M responseEntityModel,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    String? pathSuffix,
    String? contentType,
    Duration connectTimeout = const Duration(milliseconds: 15000), // 15 sec
    Duration receiveTimeout = const Duration(milliseconds: 15000), // 15 sec
    Duration sendTimeout = const Duration(milliseconds: 15000), // 15 sec
    bool showResponseErrorSnackBar = true,
    bool showLoader = false,
  }) async {
    final response = await _networkManager.coreDio.request<T, M>(
      path: path,
      type: type,
      responseEntityModel: responseEntityModel,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      pathSuffix: pathSuffix,
      contentType: contentType,
      connectionTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      showLoader: showLoader,
      headers: _generateHeaders(path: path),
    );
    if (showResponseErrorSnackBar) _showResponseErrorSnackBar(baseResponse: response);
    return response;
  }

  Future<BaseResponse<T>> primitiveRequest<T extends Object>({
    required RequestPath path,
    required RequestType type,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    String? pathSuffix,
    String? contentType,
    Duration connectTimeout = const Duration(milliseconds: 15000), // 15 sec
    Duration receiveTimeout = const Duration(milliseconds: 15000), // 15 sec
    Duration sendTimeout = const Duration(milliseconds: 15000), // 15 sec
    bool showResponseErrorSnackBar = true,
    bool showLoader = false,
  }) async {
    final response = await _networkManager.coreDio.primitiveRequest<T>(
      path: path,
      type: type,
      data: data,
      dioFormData: dioFormData,
      queryParameters: queryParameters,
      pathSuffix: pathSuffix,
      contentType: contentType,
      connectionTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      showLoader: showLoader,
      headers: _generateHeaders(path: path),
    );
    if (showResponseErrorSnackBar) _showResponseErrorSnackBar(baseResponse: response);
    return response;
  }

  void _showResponseErrorSnackBar({required BaseResponse<dynamic> baseResponse}) {
    if (baseResponse.networkError != null) {
      final scaffoldMessengerState = Locator.find<GlobalKey<ScaffoldMessengerState>>().currentState;
      assert(scaffoldMessengerState.isNotNull, 'Tried to get scaffoldMessengerState but found null');
      scaffoldMessengerState!.showSnackBar(
        SnackBar(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Error',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                baseResponse.networkError!.error.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }
  }

  Map<String, dynamic> _generateHeaders({required RequestPath path}) {
    // Generate header here i.e Bearer Token
    return {};
  }
}
