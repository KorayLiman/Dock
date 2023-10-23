import 'package:dock_flutter/dock.dart';
import 'package:flutter_test/flutter_test.dart';

enum _E {
  first,
}

void main() {
  test(
    'Generic extension test',
    () async {
      expect(1.observable, isInstanceOf<Observable<int>>());
      expect('1'.observable, isInstanceOf<Observable<String>>());
      expect(_E.first.observable, isInstanceOf<Observable<_E>>());
    },
  );
}
