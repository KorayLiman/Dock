import 'package:flutter_test/flutter_test.dart';
import 'package:dock/product/extensions/collection_extensions/list_extensions/list_extensions.dart';

void main() {
  testWidgets('List extension test', (WidgetTester tester) async {
    final dummyList = [1, 2, 3];
    expect(dummyList.notContains(4), true, reason: 'dummyList.notContains(4)');
    expect(dummyList.notContains(3), false, reason: 'dummyList.notContains(3)');
    expect(dummyList.isNotNullAndNotEmpty, true, reason: 'dummyList.isNotNullAndNotEmpty');
    List<dynamic>? nullableDummyList;
    expect(nullableDummyList.isNullOrEmpty, true, reason: 'nullableDummyList.isNullOrEmpty');
    final dummyEmptyList = <dynamic>[];
    expect(dummyEmptyList.isNullOrEmpty, true, reason: 'dummyEmptyList.isNullOrEmpty');
  });
}
