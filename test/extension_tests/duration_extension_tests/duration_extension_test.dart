import 'package:dock_flutter/src/product/extensions/extensions.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Duration extension test',
    () async {
      final stopwatch = Stopwatch();
      const delayMs = 2000;
      var i = 0;
      stopwatch.start();
      await delayMs.milliseconds.delay(() {
        i++;
      });
      stopwatch.stop();
      expect(nearEqual(stopwatch.elapsedMilliseconds.toDouble(), delayMs.toDouble(), 100), true);
      expect(i, 1);
    },
  );
}
