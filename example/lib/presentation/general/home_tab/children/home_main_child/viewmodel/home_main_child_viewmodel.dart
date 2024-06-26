import 'package:dock_flutter/dock.dart';

final class HomeMainChildViewModel extends BaseViewModel {
  final count = 0.observable;
  final weight = 80.observable;
  int age = 26;

  void incrementCounter() {
    count.value++;
  }

  void incrementWeight() {
    weight.value++;
  }

  void incrementAge() {
    // update(id: '0');
    updateAfter(
      id: '0',
      after: () {
        age++;
      },
    );
  }
}
