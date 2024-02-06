import 'package:dock_flutter/src/product/extensions/int_extensions/int_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Int Extension Test',
    () async {
      expect(5.microseconds, const Duration(microseconds: 5));
      expect(5.milliseconds, const Duration(milliseconds: 5));
      expect(5.seconds, const Duration(seconds: 5));
      expect(5.minutes, const Duration(minutes: 5));
      expect(5.hours, const Duration(hours: 5));
      expect(5.days, const Duration(days: 5));
    },
  );
}
