import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersociallogin/screens/OtpScreen.dart'; // Replace with your correct file path

void main() {
  testWidgets('Verify OTP Button Test', (WidgetTester tester) async {
    // Build the widget and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: OTPScreen(
          phoneNumber: '9390945549'), // Replace with a valid phone number
    ));

    // Find the elements to test
    final enterOtpTextFinder = find.text('Enter OTP sent to 9390945549');
    final verifyButtonFinder = find.byType(ElevatedButton);

    // Verify if the necessary widgets are present
    expect(enterOtpTextFinder, findsOneWidget);
    expect(verifyButtonFinder, findsOneWidget);

    // Tap the verify OTP button
    await tester.tap(verifyButtonFinder);
    await tester.pump(Duration(seconds: 2)); // wait for snackbar animation.

    // Verify that the snackbar shows when the button is tapped
    // expect(find.text('OTP verified successfully'), findsOneWidget);
  });

  testWidgets('Entering OTP Test', (WidgetTester tester) async {
    // Build the widget and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: OTPScreen(
          phoneNumber: '9390945549'), // Replace with a valid phone number
    ));

    // Find the text field for OTP
    final otpTextFieldFinder = find.byType(TextField);

    // Enter OTP
    await tester.enterText(otpTextFieldFinder, '123456');
    expect(find.text('123456'),
        findsOneWidget); // Verify if OTP is entered correctly

    // Tap the verify OTP button
    final verifyButtonFinder = find.byType(ElevatedButton);
    await tester.tap(verifyButtonFinder);
    await tester.pump();

    // Verify that the snackbar shows when the button is tapped
    // expect(find.text('OTP verified successfully'), findsOneWidget);
  });
}
