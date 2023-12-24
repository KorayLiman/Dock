import 'package:dio/dio.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:dock_flutter_example/product/mixin/mixin.dart';
import 'package:dock_flutter_example/product/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final class CoreDio with NetworkLoggerMixin {
  const CoreDio(this._dio);

  final Dio _dio;

  PopupManager get _popupManager => Locator.find<PopupManager>();

  OverlayManager get _overlayManager => Locator.find<OverlayManager>();

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
    final stopwatch = Stopwatch();
    try {
      if (showLoader) _popupManager.showLoader(id: loaderKey);
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _dio.options.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
      stopwatch.start();
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
      stopwatch
        ..stop()
        ..reset();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      final resp = _getPrimitiveSuccessResponse(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseTime: responseTimeMilliseconds);
      if (showSuccessResponseSnackBar) _showSuccessResponseToast(messages: resp.messages);
      return resp;
    } catch (error) {
      stopwatch
        ..stop()
        ..reset();
      if (showErrorResponseSnackBar) _showErrorResponseToast(error: error);
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
    final stopwatch = Stopwatch();
    try {
      stopwatch.start();
      if (showLoader) _popupManager.showLoader(id: loaderKey);
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _dio.options.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);

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
      stopwatch
        ..stop()
        ..reset();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      final resp = _getSuccessResponse<T, M>(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseEntityModel: responseEntityModel, responseTime: responseTimeMilliseconds);
      if (showSuccessResponseSnackBar) _showSuccessResponseToast(messages: resp.messages);
      return resp;
    } catch (error) {
      stopwatch
        ..stop()
        ..reset();
      if (showErrorResponseSnackBar) _showErrorResponseToast(error: error);
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

  void _showSuccessResponseToast({required List<String>? messages}) {
    _overlayManager.showToast(
      message: messages.isNullOrEmpty ? 'İşlem başarılı bir şekilde gerçekleşti 🥂!' : messages!.join('\n'),
      messageStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      backgroundColor: Colors.green,
      shadowColor: Colors.green.shade500,
      leading: const Icon(
        Icons.check_circle,
        color: Colors.white,
      ),
    );
  }

  void _showErrorResponseToast({required Object error}) {
    _overlayManager.showToast(
      title: 'Hata: ${error is DioException ? error.response?.statusCode : ''}',
      titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      message: '$error',
      messageMaxLines: 5,
      toastPosition: ToastPosition.top,
      dismissDirection: DismissDirection.up,
      toastDuration: 2500.milliseconds,
      messageStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
    );
  }
}
