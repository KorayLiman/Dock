import 'package:dock_flutter_example/product/enums/enums.dart';

extension RequestPathExtension on RequestPath {
  String get path => switch (this) {
        RequestPath.login => '/login',
      };
}
