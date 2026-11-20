import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:modul6/utils/snackbar_helper.dart';

void main() {
  testWidgets('shows an authentication error message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SizedBox())),
    );

    SnackBarHelper.show(
      tester.element(find.byType(SizedBox)),
      'Email/Password Salah',
    );
    await tester.pump();

    expect(find.text('Email/Password Salah'), findsOneWidget);
  });
}
