import 'package:dock_flutter/dock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Popup Manager Test',
    (tester) async {
      final navKey = GlobalKey<NavigatorState>();
      final popupManager = PopupManager(navKey);
      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navKey,
          home: const Scaffold(),
        ),
      );
      await tester.pumpAndSettle();
      popupManager.showLoader();
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      popupManager.hideLoader();
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      popupManager.showLoader(id: 1);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      popupManager.hideLoader(id: 1);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      popupManager.showLoader(id: 1);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      popupManager.hideLoader();
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      popupManager.showLoader(id: 1);
      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(() => popupManager.hideLoader(id: -1), throwsAssertionError);
      expect(() => popupManager.showLoader(id: 1), throwsAssertionError);
      popupManager.showLoader(id: 2);
      await tester.pump();
      popupManager.showLoader(id: 3);
      await tester.pump();
      expect(popupManager.routes.length, 3);
      popupManager.hideLoader(id: 2);
      expect(popupManager.routes.length, 2);
      expect(popupManager.routes.where((element) => element.id == 2).isEmpty, true);
      popupManager.hideLoader(id: 1);
      expect(popupManager.routes.length, 1);
      expect(popupManager.routes.where((element) => element.id == 1).isEmpty, true);
      popupManager.showLoader(id: 2);
      await tester.pump();
      expect(popupManager.routes.length, 2);
      popupManager.hideLoader();
      expect(popupManager.routes.length, 1);
      expect(popupManager.routes.where((element) => element.id == 2).isEmpty, true);
      expect(popupManager.routes.where((element) => element.id == 3).isNotEmpty, true);
      popupManager.hideLoader();
      expect(popupManager.routes.length, 0);
    },
  );
}
