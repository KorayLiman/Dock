import 'package:dio/dio.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/core/network/network.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';

abstract base class BaseService {
  const BaseService();

  NetworkManager get _networkManager => NetworkManager.instance;
  static const _connectTimeout = Duration(seconds: 25);
  static const _receiveTimeout = Duration(seconds: 25);
  static const _sendTimeout = Duration(seconds: 25);
  static const _showLoader = false;
  static const _showErrorResponseSnackBar = true;
  static const _showSuccessResponseSnackBar = true;

  Future<BaseResponse<T>> request<T, M extends BaseModel<dynamic>>({
    required RequestPath path,
    required RequestType type,
    required M responseEntityModel,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    String? pathSuffix,
    String? contentType,
    Duration connectTimeout = _connectTimeout,
    Duration receiveTimeout = _receiveTimeout,
    Duration sendTimeout = _sendTimeout,
    bool showErrorResponseSnackBar = _showErrorResponseSnackBar,
    bool showSuccessResponseSnackBar = _showSuccessResponseSnackBar,
    bool showLoader = _showLoader,
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
      showErrorResponseSnackBar: showErrorResponseSnackBar,
      showSuccessResponseSnackBar: showSuccessResponseSnackBar,
      headers: _generateHeaders(path: path),
    );

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
    Duration connectTimeout = _connectTimeout,
    Duration receiveTimeout = _receiveTimeout,
    Duration sendTimeout = _sendTimeout,
    bool showErrorResponseSnackBar = _showErrorResponseSnackBar,
    bool showSuccessResponseSnackBar = _showSuccessResponseSnackBar,
    bool showLoader = _showLoader,
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
      showErrorResponseSnackBar: showErrorResponseSnackBar,
      showSuccessResponseSnackBar: showSuccessResponseSnackBar,
      headers: _generateHeaders(path: path),
    );
    return response;
  }

  Map<String, dynamic> _generateHeaders({required RequestPath path}) {
    // Generate header here i.e Bearer Token
    return {};
  }
}
