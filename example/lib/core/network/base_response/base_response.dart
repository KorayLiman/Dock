import 'package:dock_flutter_example/product/model/model.dart';

final class BaseResponse<T> {
  const BaseResponse({required this.data, required this.networkError});

  final T? data;
  final NetworkError? networkError;
}
