import 'package:dock_flutter/dock.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel {}

final class _TestViewModel2 extends BaseViewModel {}

final class _TestViewModel3 extends BaseViewModel {}

void main() {
  test(
    'Dependency Injection Test 1',
    () async {
      final locator = TestLocator;
      final i1 = locator.register(_TestViewModel());

      locator.find<_TestViewModel>();
      expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
      locator.unregister(instance: i1);
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
      locator
        ..register(_TestViewModel())
        ..unregister<_TestViewModel>();
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
      final i3 = locator.register(_TestViewModel());
      locator.unregister<_TestViewModel>(instance: i3);
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 2',
    () async {
      final locator = TestLocator;
      final i1 = locator.register<_TestViewModel>(_TestViewModel());

      locator.find<_TestViewModel>();
      expect(() => locator.register<_TestViewModel>(_TestViewModel()), throwsA(isA<LocatorException>()));
      locator.unregister(instance: i1);
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
      locator
        ..register<_TestViewModel>(_TestViewModel())
        ..unregister<_TestViewModel>();
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 3',
    () async {
      final locator = TestLocator..registerLazy(_TestViewModel.new);

      expect(() => locator.registerLazy(_TestViewModel.new), throwsA(isA<LocatorException>()));
      expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
      locator
        ..find<_TestViewModel>()
        ..unregister<_TestViewModel>();
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
      locator.registerLazy(_TestViewModel.new);

      expect(() => locator.registerLazy(_TestViewModel.new), throwsA(isA<LocatorException>()));
      expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
      final i2 = locator.find<_TestViewModel>();
      locator.unregister(instance: i2);
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);

      locator.registerLazy(_TestViewModel.new);

      expect(() => locator.registerLazy(_TestViewModel.new), throwsA(isA<LocatorException>()));
      expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
      final i3 = locator.find<_TestViewModel>();
      locator.unregister<_TestViewModel>(instance: i3);
      expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
      expect(locator.tryFind<_TestViewModel>(), isNull);
    },
  );

  test(
    'Dependency Injection Test 4',
    () async {
      final locator = TestLocator
        ..register<_TestViewModel>(_TestViewModel())
        ..register<_TestViewModel2>(_TestViewModel2())
        ..register<_TestViewModel3>(_TestViewModel3())
        ..find<_TestViewModel>()
        ..find<_TestViewModel2>()
        ..find<_TestViewModel3>()
        ..unregisterAll();
      expect(locator.tryFind<_TestViewModel>(), isNull);
      expect(locator.tryFind<_TestViewModel2>(), isNull);
      expect(locator.tryFind<_TestViewModel3>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 5',
    () async {
      final locator = TestLocator
        ..registerLazy<_TestViewModel>(_TestViewModel.new)
        ..registerLazy<_TestViewModel2>(_TestViewModel2.new)
        ..registerLazy<_TestViewModel3>(_TestViewModel3.new)
        ..find<_TestViewModel>()
        ..find<_TestViewModel2>()
        ..find<_TestViewModel3>()
        ..unregisterAll();
      expect(locator.tryFind<_TestViewModel>(), isNull);
      expect(locator.tryFind<_TestViewModel2>(), isNull);
      expect(locator.tryFind<_TestViewModel3>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 6',
    () async {
      final locator = TestLocator
        ..registerLazy<_TestViewModel>(_TestViewModel.new)
        ..registerLazy<_TestViewModel2>(_TestViewModel2.new)
        ..registerLazy<_TestViewModel3>(_TestViewModel3.new);
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);

      locator.unregisterAll();
      expect(locator.tryFind<_TestViewModel>(), isNull);
      expect(locator.tryFind<_TestViewModel2>(), isNull);
      expect(locator.tryFind<_TestViewModel3>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 7',
    () async {
      final locator = TestLocator
        ..registerLazy<_TestViewModel>(_TestViewModel.new, keepAlive: true)
        ..registerLazy<_TestViewModel2>(_TestViewModel2.new, keepAlive: true)
        ..registerLazy<_TestViewModel3>(_TestViewModel3.new, keepAlive: true);
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);

      locator.unregisterAll();
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);
    },
  );
  test(
    'Dependency Injection Test 8',
    () async {
      final locator = TestLocator
        ..registerLazy<_TestViewModel>(_TestViewModel.new, keepAlive: true)
        ..registerLazy<_TestViewModel2>(_TestViewModel2.new, keepAlive: true)
        ..registerLazy<_TestViewModel3>(_TestViewModel3.new, keepAlive: true);
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);

      locator.unregisterAll(force: true);
      expect(locator.tryFind<_TestViewModel>(), isNull);
      expect(locator.tryFind<_TestViewModel2>(), isNull);
      expect(locator.tryFind<_TestViewModel3>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 9',
    () async {
      final locator = TestLocator
        ..register<_TestViewModel>(_TestViewModel(), keepAlive: true)
        ..register<_TestViewModel2>(_TestViewModel2(), keepAlive: true)
        ..register<_TestViewModel3>(_TestViewModel3(), keepAlive: true);
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);

      locator.unregisterAll(force: true);
      expect(locator.tryFind<_TestViewModel>(), isNull);
      expect(locator.tryFind<_TestViewModel2>(), isNull);
      expect(locator.tryFind<_TestViewModel3>(), isNull);
    },
  );
  test(
    'Dependency Injection Test 10',
    () async {
      final locator = TestLocator
        ..register<_TestViewModel>(_TestViewModel(), keepAlive: true)
        ..register<_TestViewModel2>(_TestViewModel2(), keepAlive: true)
        ..register<_TestViewModel3>(_TestViewModel3(), keepAlive: true);
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);

      locator.unregisterAll();
      expect(locator.tryFind<_TestViewModel>(), isNotNull);
      expect(locator.tryFind<_TestViewModel2>(), isNotNull);
      expect(locator.tryFind<_TestViewModel3>(), isNotNull);
    },
  );
}
