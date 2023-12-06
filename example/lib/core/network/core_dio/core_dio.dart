import 'package:dio/dio.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/core/navigation/app_router/app_router.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';
import 'package:dock_flutter_example/product/extensions/extension.dart';
import 'package:dock_flutter_example/product/mixin/mixin.dart';
import 'package:dock_flutter_example/product/model/model.dart';
import 'package:flutter/foundation.dart';

final class CoreDio with NetworkLoggerMixin {
  CoreDio({required BaseOptions baseOptions}) {
    _baseOptions = baseOptions;
    _dio = Dio(_baseOptions);
  }

  late final BaseOptions _baseOptions;
  late final Dio _dio;
  final LoaderManager _loaderManager = LoaderManager(AppRouter.find.navigatorKey);

  Future<BaseResponse<T>> primitiveRequest<T extends Object>({
    required RequestPath path,
    required RequestType type,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool showLoader = false,
  }) async {
    try {
      if (showLoader) _loaderManager.show();
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _baseOptions.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
      final stopwatch = Stopwatch()..start();
      final response = await _dio.request<T>(
        pathSuffix == null ? path.path : '${path.path}/$pathSuffix',
        queryParameters: queryParameters?.toJson(),
        data: dioFormData ?? data?.toJson(),
        options: Options(
          method: type.type,
          headers: headers,
          contentType: contentType,
        ),
      );
      stopwatch.stop();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      return _getPrimitiveSuccessResponse(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseTime: responseTimeMilliseconds);
    } catch (exception) {
      return _getPrimitiveErrorResponse(error: exception, requestUrl: '${_dio.options.baseUrl}${path.path}');
    } finally {
      _loaderManager.hide();
    }
  }

  Future<BaseResponse<T>> request<T, M extends BaseModel<dynamic>>({
    required RequestPath path,
    required RequestType type,
    required M responseEntityModel,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    String? pathSuffix,
    String? contentType,
    Duration? connectionTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    bool showLoader = false,
  }) async {
    try {
      if (showLoader) _loaderManager.show();
      if (kDebugMode) logRequestInfo(requestUrl: '${_dio.options.baseUrl}${path.path}', type: type, data: data, pathSuffix: pathSuffix, headers: headers, queryParameters: queryParameters);
      _dio.options = _baseOptions.copyWith(connectTimeout: connectionTimeout, receiveTimeout: receiveTimeout, sendTimeout: sendTimeout);
      final stopwatch = Stopwatch()..start();
      final response = await _dio.request<dynamic>(
        pathSuffix == null ? path.path : '${path.path}$pathSuffix',
        queryParameters: queryParameters?.toJson(),
        data: dioFormData ?? data?.toJson(),
        options: Options(
          method: type.type,
          headers: headers,
          contentType: contentType,
        ),
      );
      stopwatch.stop();
      final responseTimeMilliseconds = stopwatch.elapsedMilliseconds;
      return _getSuccessResponse<T, M>(response: response, requestUrl: '${_dio.options.baseUrl}${path.path}', responseEntityModel: responseEntityModel, responseTime: responseTimeMilliseconds);
    } catch (exception) {
      return _getErrorResponse(error: exception, requestUrl: '${_dio.options.baseUrl}${path.path}');
    } finally {
      _loaderManager.hide();
    }
  }

  BaseResponse<T> _getPrimitiveSuccessResponse<T extends Object>({required Response<T> response, required String requestUrl, required int responseTime}) {
    if (kDebugMode) logResponseInfo(response: response, responseTime: responseTime, requestUrl: requestUrl);
    return BaseResponse<T>(data: response.data, networkError: null);
  }

  BaseResponse<T> _getSuccessResponse<T, M extends BaseModel<dynamic>>({required Response<dynamic> response, required String requestUrl, required M responseEntityModel, required int responseTime}) {
    if (kDebugMode) logResponseInfo(response: response, responseTime: responseTime, requestUrl: requestUrl);
    final data = _getData(jsonResponse: response.data, responseEntityModel: responseEntityModel) as T?;
    return BaseResponse<T>(data: data, networkError: null);
  }

  BaseResponse<T> _getPrimitiveErrorResponse<T extends Object>({required Object error, required String requestUrl}) {
    final statusCode = error is DioException ? error.response?.statusCode : null;
    if (kDebugMode) logErrorResponseInfo(statusCode: statusCode, error: error, requestUrl: requestUrl);
    return BaseResponse<T>(data: null, networkError: NetworkError(error: error, statusCode: statusCode ?? -1));
  }

  BaseResponse<T> _getErrorResponse<T>({required Object error, required String requestUrl}) {
    final statusCode = error is DioException ? error.response?.statusCode : null;
    if (kDebugMode) logErrorResponseInfo(statusCode: statusCode, error: error, requestUrl: requestUrl);
    return BaseResponse<T>(data: null, networkError: NetworkError(error: error, statusCode: statusCode ?? -1));
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
}
