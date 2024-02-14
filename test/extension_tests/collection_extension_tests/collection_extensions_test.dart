import 'package:dock_flutter/dock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Collection Extension Test', () {
    test('List extension test', () async {
      List<dynamic>? nList;
      expect(nList.isNullOrEmpty, true);
      expect(nList.notContains(null), true);
      expect(nList.notContains(1), true);
      nList = [];
      expect(nList.isNullOrEmpty, true);
      nList.add(1);
      expect(nList.isNullOrEmpty, false);
      expect(nList.isNotNullAndNotEmpty, true);
      final dummyList = [1, 2, 3];
      expect(dummyList.notContains(4), true);
      expect(dummyList.notContains(3), false);
      expect(dummyList.isNotNullAndNotEmpty, true);
    });
    test('Map extension test', () async {
      Map<dynamic, dynamic>? nMap;
      expect(nMap.isNullOrEmpty, true);
      expect(nMap.notContainsKey(null), true);
      expect(nMap.notContainsKey(1), true);
      nMap = {};
      expect(nMap.isNullOrEmpty, true);
      nMap[0] = 0;
      expect(nMap.isNullOrEmpty, false);
      expect(nMap.isNotNullAndNotEmpty, true);
      final dummyMap = {0: 0, 1: 1, 2: 2, 3: 3};
      expect(dummyMap.notContainsKey(4), true);
      expect(dummyMap.notContainsKey(3), false);
      expect(dummyMap.notContainsValue(4), true);
      expect(dummyMap.notContainsValue(3), false);
      expect(dummyMap.isNotNullAndNotEmpty, true);
    });
    test('Set extension test', () async {
      Set<dynamic>? nSet;
      expect(nSet.isNullOrEmpty, true);
      expect(nSet.isNotNullAndNotEmpty, false);
      nSet = {};
      expect(nSet.isNullOrEmpty, true);
      expect(nSet.isNotNullAndNotEmpty, false);
      nSet.add(1);
      expect(nSet.isNullOrEmpty, false);
      expect(nSet.isNotNullAndNotEmpty, true);
    });
  });
}
