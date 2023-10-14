import 'package:dock_flutter/product/extensions/collection_extensions/list_extensions/list_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('List extension test', (WidgetTester tester) async {
    final dummyList = [1, 2, 3];
    expect(dummyList.notContains(4), true);
    expect(dummyList.notContains(3), false);
    expect(dummyList.isNotNullAndNotEmpty, true);
    List<dynamic>? nullableDummyList;
    expect(nullableDummyList.isNullOrEmpty, true);
    final dummyEmptyList = <dynamic>[];
    expect(dummyEmptyList.isNullOrEmpty, true);
  });
}
