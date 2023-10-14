import 'package:dock_flutter/core/base/viewmodel/base_viewmodel.dart';
import 'package:dock_flutter/product/extensions/extensions.dart';

final class HomeMainChildViewModel extends BaseViewModel<HomeMainChildViewModel> {
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
