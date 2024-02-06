import 'package:dock_flutter/src/product/extensions/object_extensions/object_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Object Extension Test',
    () async {
      Object? o;
      expect(o.isNull, true);
      expect(o.isNotNull, false);
      o = Object();
      expect(o.isNull, false);
      expect(o.isNotNull, true);
    },
  );
}
