import 'package:dio/dio.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:dock_flutter_example/product/mixin/mixin.dart';
import 'package:dock_flutter_example/product/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final class CoreDio with NetworkLoggerMixin {
  const CoreDio(this._dio);

  final Dio _dio;

  PopupManager get _popupManager => PopupManager(AppRouter.find.navigatorKey);

  Future<BaseResponse<T>> primitiveRequest<T extends Object>({
    required RequestPath path,
    required RequestType type,
    required bool showLoader,
    required bool showErrorResponseSnackBar,
    required bool showSuccessResponseSnackBar,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    final loaderKey = UniqueKey();
    try {
      if (showLoader) _popupManager.showLoader(id: loaderKey);
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _dio.options.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
      final stopwatch = Stopwatch()..start();
      final response = await _dio.request<T>(
        pathSuffix == null ? path.path : '${path.path}/$pathSuffix',
        queryParameters: queryParameters?.toJson(),
        data: dioFormData ?? data?.toJson(),
        options: Options(
          method: type.type,
          headers: _generateHeaders(path: path),
          contentType: contentType,
        ),
      );
      stopwatch.stop();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      final resp = _getPrimitiveSuccessResponse(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseTime: responseTimeMilliseconds);
      if (showSuccessResponseSnackBar) _showSuccessResponseSnackBar(messages: resp.messages);
      return resp;
    } catch (error) {
      if (showErrorResponseSnackBar) _showErrorResponseSnackBar(error: error);
      return _getPrimitiveErrorResponse(error: error, requestUrl: '${_dio.options.baseUrl}${path.path}');
    } finally {
      _popupManager.hideLoader(id: loaderKey);
    }
  }

  Future<BaseResponse<T>> request<T, M extends BaseModel<dynamic>>({
    required RequestPath path,
    required RequestType type,
    required M responseEntityModel,
    required bool showLoader,
    required bool showErrorResponseSnackBar,
    required bool showSuccessResponseSnackBar,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    final loaderKey = UniqueKey();
    try {
      if (showLoader) _popupManager.showLoader(id: loaderKey);
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _dio.options.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
      final stopwatch = Stopwatch()..start();
      final response = await _dio.request<Map<String, dynamic>>(
        pathSuffix == null ? path.path : '${path.path}$pathSuffix',
        queryParameters: queryParameters?.toJson(),
        data: dioFormData ?? data?.toJson(),
        options: Options(
          method: type.type,
          headers: _generateHeaders(path: path),
          contentType: contentType,
        ),
      );
      stopwatch.stop();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      final resp = _getSuccessResponse<T, M>(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseEntityModel: responseEntityModel, responseTime: responseTimeMilliseconds);
      if (showSuccessResponseSnackBar) _showSuccessResponseSnackBar(messages: resp.messages);
      return resp;
    } catch (error) {
      if (showErrorResponseSnackBar) _showErrorResponseSnackBar(error: error);
      return _getErrorResponse(error: error, requestUrl: '${_dio.options.baseUrl}${path.path}');
    } finally {
      _popupManager.hideLoader(id: loaderKey);
    }
  }

  Map<String, dynamic> _generateHeaders({required RequestPath path}) {
    // Generate header here i.e Bearer Token
    return {};
  }

  BaseResponse<T> _getPrimitiveSuccessResponse<T extends Object>({required Response<T> response, required String requestUrl, required int responseTime}) {
    if (kDebugMode) logResponseInfo(response: response, responseTime: responseTime, requestUrl: requestUrl);
    return BaseResponse<T>(data: response.data);
  }

  BaseResponse<T> _getSuccessResponse<T, M extends BaseModel<dynamic>>({required Response<Map<String, dynamic>> response, required String requestUrl, required M responseEntityModel, required int responseTime}) {
    if (kDebugMode) logResponseInfo(response: response, responseTime: responseTime, requestUrl: requestUrl);
    final data = _getData(jsonResponse: response.data?['data'], responseEntityModel: responseEntityModel) as T?;
    return BaseResponse<T>(data: data, success: response.data?['success'] as bool?, messages: (response.data?['messages'] as List?)?.cast<String>());
  }

  BaseResponse<T> _getPrimitiveErrorResponse<T extends Object>({required Object error, required String requestUrl}) {
    final statusCode = error is DioException ? error.response?.statusCode : null;
    if (kDebugMode) logErrorResponseInfo(statusCode: statusCode, error: error, requestUrl: requestUrl);
    return BaseResponse<T>(requestError: RequestError(error: error, statusCode: statusCode ?? -1));
  }

  BaseResponse<T> _getErrorResponse<T>({required Object error, required String requestUrl}) {
    final statusCode = error is DioException ? error.response?.statusCode : null;
    if (kDebugMode) logErrorResponseInfo(statusCode: statusCode, error: error, requestUrl: requestUrl);
    return BaseResponse<T>(requestError: RequestError(error: error, statusCode: statusCode ?? -1));
  }

  T? _getData<T, M extends BaseModel<dynamic>>({required dynamic jsonResponse, required M responseEntityModel}) {
    if (jsonResponse is List<Map<String, dynamic>>) {
      return jsonResponse.map((e) => responseEntityModel.fromJson(e)).toList().cast<M>() as T;
    } else if (jsonResponse is Map<String, dynamic>) {
      return responseEntityModel.fromJson(jsonResponse) as T;
    } else {
      return null;
    }
  }

  void _showSuccessResponseSnackBar({required List<String>? messages}) {
    final scaffoldMessengerState = Locator.find<GlobalKey<ScaffoldMessengerState>>().currentState;
    assert(scaffoldMessengerState.isNotNull, 'Tried to get scaffoldMessengerState but found null');
    scaffoldMessengerState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (messages.isNullOrEmpty)
              const Text(
                'Başarılı',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            else
              ...messages!.map(
                (e) => Text(
                  e,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showErrorResponseSnackBar({required Object error}) {
    final scaffoldMessengerState = Locator.find<GlobalKey<ScaffoldMessengerState>>().currentState;
    assert(scaffoldMessengerState.isNotNull, 'Tried to get scaffoldMessengerState but found null');
    scaffoldMessengerState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Hata',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Blank(6),
            Text(
              '$error',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
