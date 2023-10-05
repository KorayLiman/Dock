import 'package:liman/core/base/viewmodel/base_viewmodel.dart';
import 'package:liman/product/extensions/extensions.dart';

final class HomeMainChildViewModel extends BaseViewModel<HomeMainChildViewModel> {
  final count = 0.observable;
  final weight = 0.5.observable;
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
