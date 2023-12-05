import 'package:dock_flutter_example/product/enums/enum.dart';

extension RequestTypeExtension on RequestType {
  String get type => switch (this) {
        RequestType.get => 'GET',
        RequestType.post => 'POST',
        RequestType.put => 'PUT',
        RequestType.delete => 'DELETE',
      };
}
