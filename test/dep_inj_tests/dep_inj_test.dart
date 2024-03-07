import 'package:dock_flutter/dock.dart';
import 'package:dock_flutter/src/core/locator/register_strategy.dart';
import 'package:flutter_test/flutter_test.dart';

final class _TestViewModel extends BaseViewModel {}

final class _TestViewModel2 extends BaseViewModel {}

final class _TestViewModel3 extends BaseViewModel {}

void main() {
  group('Dependency Injection Test', () {
    test(
      'Dependency Injection Test 1',
      () async {
        final locator = TestLocator
          ..register(_TestViewModel())
          ..find<_TestViewModel>();
        expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
        locator.unregister<_TestViewModel>();
        expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
        expect(locator.tryFind<_TestViewModel>(), isNull);
        locator
          ..register(_TestViewModel())
          ..unregister<_TestViewModel>();
        expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
        expect(locator.tryFind<_TestViewModel>(), isNull);
        locator
          ..register(_TestViewModel())
          ..unregister<_TestViewModel>();
        expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
        expect(locator.tryFind<_TestViewModel>(), isNull);
      },
    );
    test(
      'Dependency Injection Test 2',
      () async {
        final locator = TestLocator
          ..register<_TestViewModel>(_TestViewModel())
          ..find<_TestViewModel>();
        expect(() => locator.register<_TestViewModel>(_TestViewModel()), throwsA(isA<LocatorException>()));
        locator.unregister<_TestViewModel>();
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

        locator.unregister<_TestViewModel>();
        expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));
        expect(locator.tryFind<_TestViewModel>(), isNull);

        locator.registerLazy(_TestViewModel.new);

        expect(() => locator.registerLazy(_TestViewModel.new), throwsA(isA<LocatorException>()));
        expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
        locator
          ..find<_TestViewModel>()
          ..unregister<_TestViewModel>();
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
        final locator = TestLocator..register(_TestViewModel());
        expect(() => locator.register(_TestViewModel()), throwsA(isA<LocatorException>()));
        locator.register(_TestViewModel(), strategy: RegisterStrategy.override);
        expect(() => locator.find<_TestViewModel>(), returnsNormally);
        expect(locator.tryFind<_TestViewModel>(), isNotNull);
        locator.register(_TestViewModel(), tag: 'one');
        expect(
          () {
            locator
              ..find<_TestViewModel>()
              ..find<_TestViewModel>(tag: 'one');
          },
          returnsNormally,
        );
        locator.unregister<_TestViewModel>(tag: 'one');
        expect(() => locator.find<_TestViewModel>(tag: 'one'), throwsA(isA<LocatorException>()));
        expect(locator.tryFind<_TestViewModel>(), isNotNull);
        locator.unregister<_TestViewModel>();
        expect(() => locator.find<_TestViewModel>(), throwsA(isA<LocatorException>()));

        locator.register(_TestViewModel(), tag: 'one');
        expect(() => locator.register(_TestViewModel(), tag: 'one'), throwsA(isA<LocatorException>()));
        expect(() => locator.register(_TestViewModel(), tag: 'one', strategy: RegisterStrategy.override), returnsNormally);
        expect(() => locator.tryFind<_TestViewModel>(tag: 'one'), isNotNull);
        expect(locator.tryFind<_TestViewModel>(), isNull);
      },
    );
  });
}
