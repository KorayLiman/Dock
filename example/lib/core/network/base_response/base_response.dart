import 'package:dock_flutter_example/product/model/model.dart';

final class BaseResponse<T> {
  const BaseResponse({this.data, this.requestError, this.messages, this.success});

  final T? data;
  final bool? success;
  final List<String>? messages;
  final RequestError? requestError;
}
