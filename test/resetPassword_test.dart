import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersociallogin/Screens/resetPassword.dart'; // Replace with the actual file path of ConfirmPassword.dart

void main() {
  group('_ConfirmPassword Widget Test', () {
    late Widget testWidget;
    late ConfirmPassword confirmPasswordWidget;

    setUp(() {
      testWidget = MaterialApp(
        home: ConfirmPassword(
          title: 'Reset Password',
          email: 'test@example.com',
        ),
      );
      confirmPasswordWidget = ConfirmPassword(
        title: 'Reset Password',
        email: 'test@example.com',
      );
    });

    testWidgets('Widgets Render Test', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('enter code'), findsOneWidget);
      expect(find.text('enter new Password'), findsOneWidget);
      expect(find.text('confirm Password'), findsOneWidget);
      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('Password Validation Test', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Test invalid password
      confirmPasswordWidget.newPasswordController.text = 'weak';
      confirmPasswordWidget.confirmPasswordController.text = 'weak';
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.text('Password must be at least 8 characters with no spaces'),
          findsOneWidget);

      // Test valid password
      confirmPasswordWidget.newPasswordController.text = 'Strong!Pass123';
      confirmPasswordWidget.confirmPasswordController.text = 'Strong!Pass123';
      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Validate that error message is not displayed
      expect(find.text('Password must be at least 8 characters with no spaces'),
          findsNothing);
    });

    testWidgets('Password Match Test', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);

      // Test passwords that do not match
      confirmPasswordWidget.newPasswordController.text = 'Password1!';
      confirmPasswordWidget.confirmPasswordController.text = 'Password2!';
      await tester.tap(find.text('Submit'));
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);

      // Test passwords that match
      confirmPasswordWidget.newPasswordController.text = 'Password1!';
      confirmPasswordWidget.confirmPasswordController.text = 'Password1!';
      await tester.tap(find.text('Submit'));
      await tester.pump();

      // Validate that error message is not displayed
      expect(find.text('Passwords do not match'), findsNothing);
    });

    // Add more test cases to simulate different scenarios and edge cases.
  });
}
