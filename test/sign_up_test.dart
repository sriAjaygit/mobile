// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fluttersociallogin/Screens/signup.dart'; // Adjust import path as needed

// void main() {
//   testWidgets('SignUp Widget Test', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: SignUp(title: 'Test', email: 'test@example.com'),
//     ));

//     // Check if the registration button is displayed
//     expect(find.text('Submit'), findsOneWidget);

//     // Trigger validation without entering any data
//     await tester.tap(find.text('Submit'));
//     await tester.pump();

//     // Ensure form validation errors are shown near respective fields
//     expect(find.text('Please enter a valid name'),
//         findsNWidgets(2)); // Two name fields are validated
//     expect(find.text('please enter email address'), findsOneWidget);
//     // expect(
//     //     find.text('Password must be at least 10 characters'), findsOneWidget);
//     expect(find.text('Please enter a valid 10-digit phone number'),
//         findsOneWidget);

//     // Enter valid data into the text fields
//     await tester.enterText(
//         find.widgetWithText(TextFormField, 'Enter your first name'), 'John');
//     await tester.enterText(
//         find.widgetWithText(TextFormField, 'Enter your last name'), 'Doe');
//     await tester.enterText(
//         find.widgetWithText(TextFormField, 'Enter your email'),
//         'john.doe@example.com');
//     await tester.enterText(
//         find.widgetWithText(TextFormField, 'Enter your Password'),
//         'StrongPassword123!');
//     await tester.enterText(
//         find.widgetWithText(TextFormField, 'Enter your PhoneNumber'),
//         '1234567890');

//     // Trigger validation after entering valid data
//     // await tester.ensureVisible(find.text('Submit'));
//     // await tester.tap(find.text('Submit'));
//     // await tester.pumpAndSettle();

//     await tester.tap(find.text('Submit'));

//     // Wait for the asynchronous operations to complete
//     await tester
//         .pumpAndSettle(Duration(seconds: 2)); // Adjust the duration as needed

//     // Ensure the registration function is called
//     // For simplicity, check if SnackBar is displayed after successful registration
//     expect(find.text('Registration successful!'), findsOneWidget);

//     // Test navigation to the login page after successful registration
//     expect(find.text('Login'), findsOneWidget);
//   });
// }

// import 'dart:convert';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fluttersociallogin/Screens/signup.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:fluttersociallogin/api_constants.dart'; // Import your API constants file
// import 'package:fluttersociallogin/screens/signup.dart'; // Import the file where registerUser method resides

// class MockHttpClient extends Mock implements http.Client {}

// void main() {
//   group('Register User', () {
//     MockHttpClient mockHttpClient;
//     SignUp registerUserClass; // Replace 'YourRegisterUserClass' with your class name

//     setUp(() {
//       mockHttpClient = MockHttpClient();
//       registerUserClass = SignUp(httpClient: mockHttpClient);
//     });

//     test('Successful Registration', () async {
//       final mockResponseData = {
//         "message": "Registration successful!",
//         // Add other fields as needed based on your response structure
//       };
//       final expectedResponse = http.Response(
//         jsonEncode(mockResponseData),
//         201,
//       );

//       when(mockHttpClient.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
//           .thenAnswer((_) async => expectedResponse);

//       await registerUserClass.registerUser();

//       verify(mockHttpClient.post(
//         Uri.parse(api_constants.register),
//         body: anyNamed('body'),
//         headers: {'Content-Type': 'application/json'},
//       )).called(1);

//       // Add further verifications/assertions as needed for your specific case
//     });

//     test('Existing User', () async {
//       final mockErrorResponse = http.Response('user already exists login with other credentials', 500);

//       when(mockHttpClient.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
//           .thenAnswer((_) async => mockErrorResponse);

//       await registerUserClass.registerUser();

//       // Add assertions/verifications for handling existing users
//     });

//     test('Failed Registration', () async {
//       final mockErrorResponse = http.Response('Some error occurred', 400);

//       when(mockHttpClient.post(any, body: anyNamed('body'), headers: anyNamed('headers')))
//           .thenAnswer((_) async => mockErrorResponse);

//       await registerUserClass.registerUser();

//       // Add assertions/verifications for handling failed registrations
//     });

//     // Add more tests for edge cases, error scenarios, etc., as needed
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersociallogin/main.dart';
import 'package:fluttersociallogin/screens/signup.dart';
import 'package:fluttersociallogin/screens/signup.dart'; // Replace with your actual file

void main() {
  testWidgets('Registration screen form submission',
      (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(
        home: SignUp(
      title: '',
      email: '',
    ))); // Replace with your registration screen widget

    await tester.pumpWidget(MaterialApp(
        home: SignUp(
      title: '',
      email: '',
    )));
    await tester.pump(); // Wait for the widget to be fully built
    // Enter text into the TextFormField widgets
    await tester.enterText(find.byKey(const Key('firstName')), 'John');
    await tester.enterText(find.byKey(const Key('lastName')), 'Doe');
    await tester.enterText(
        find.byKey(const Key('emailAddress')), 'john@example.com');
    await tester.enterText(find.byKey(const Key('password')), 'password123');
    await tester.enterText(
        find.byKey(const Key('contactNumber')), '1234567890');

    // Tap the submit button
    await tester.tap(find.text('Submit'));
    await tester.pump();

    // Verify that the form was validated and processed (Navigate to Login screen)
    expect(find.text('Registration successful!'), findsOneWidget);
    expect(find.byType(Login),
        findsOneWidget); // Replace 'Login' with your login screen widget
  });
}
