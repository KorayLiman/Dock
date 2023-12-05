import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter_example/core/base/model/model.dart';
import 'package:dock_flutter_example/product/enums/enums.dart';

mixin class NetworkLoggerMixin {
  void logRequestInfo({
    required String requestUrl,
    required RequestType type,
    BaseModel<dynamic>? data,
    FormData? dioFormData,
    BaseModel<dynamic>? queryParameters,
    String? pathSuffix,
    Map<String, dynamic>? headers,
  }) {
    final requestLog = """
REQUEST
->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->
Request Url: $requestUrl,
Method: ${type.name}
DateTime: ${DateTime.now().toddMMyyyyHHmm}
Query Parameters: ${jsonEncode(queryParameters?.toJson(), toEncodable: (Object? unEncodable) => "Unencodable value of type ->${unEncodable.runtimeType}<-")}
Request Data: ${jsonEncode(data?.toJson(), toEncodable: (Object? unEncodable) => "Unencodable value of type ->${unEncodable.runtimeType}<-")}
Request DioFormData: ${dioFormData?.fields} ${dioFormData?.files}
Path Suffix: $pathSuffix
Headers: $headers
->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->""";
    Logger.logMsg(msg: requestLog, color: LogColors.yellow);
  }

  void logResponseInfo({
    required Response<dynamic> response,
    required int responseTime,
    required String requestUrl,
  }) {
    final responseLog = """
RESPONSE
<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-
Request Url: $requestUrl
DateTime: ${DateTime.now().toddMMyyyyHHmm}
Response Time: $responseTime milliseconds
Headers: ${response.requestOptions.headers}
Response Status Code: ${response.statusCode}
Response Status Message: ${response.statusMessage ?? "null"}
Response Data: ${response.data}
<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-<-""";
    Logger.logMsg(msg: responseLog);
  }

  void logErrorResponseInfo({required int? statusCode, required Object error, required String requestUrl}) {
    final errorResponseLog = '''
REQUEST ERROR
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
Status Code: $statusCode
Request Url: $requestUrl
Error String: $error
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX''';
    Logger.logMsg(msg: errorResponseLog, color: LogColors.red);
  }
}
