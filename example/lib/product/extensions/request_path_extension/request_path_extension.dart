import 'package:dock_flutter_example/product/enums/enum.dart';

extension RequestPathExtension on RequestPath {
  String get path => switch (this) {
        RequestPath.products => '/products',
      };
}
