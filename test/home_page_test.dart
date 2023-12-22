// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fluttersociallogin/homePage.dart';
// // Adjust the import path

// void main() {
//   testWidgets('HomePage UI Test', (WidgetTester tester) async {
//     await tester.pumpWidget(MaterialApp(
//       home: HomePage(email: 'test@example.com'),
//     ));

//     expect(find.text('Home Page'), findsOneWidget);
//     expect(find.text('test@example.com'), findsOneWidget);
//     expect(find.byIcon(Icons.home), findsOneWidget);

//     // Tap on the Settings icon
//     await tester.tap(find.byIcon(Icons.settings));
//     await tester.pumpAndSettle();

//     expect(find.text('Settings'), findsOneWidget);
//     // expect(find.text('Home'), findsNothing);

//     await tester.pumpAndSettle();

//     // Tap on the Go Back button
//     // await tester.tap(find.byType(ElevatedButton));
//     await tester.tap(find.byKey(Key('goBackButton')));
//     await tester.pumpAndSettle();

//     expect(find.text('Login'), findsOneWidget);
//     expect(find.text('Home'), findsNothing);
//   });
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fluttersociallogin/HomePage.dart';

// void main() {
//   testWidgets('HomePage Widget Test', (WidgetTester tester) async {
//     // Build our widget and trigger a frame.
//     await tester.pumpWidget(
//       MaterialApp(
//         home: HomePage(email: 'test@example.com'),
//       ),
//     );

//     // Verify that the title 'Home Page' appears in the AppBar.
//     expect(find.text('Home Page'), findsOneWidget);

//     // Verify that 'Home' tab is initially selected.
//     expect(find.text('Home'), findsOneWidget);
//     expect(find.text('Map'), findsOneWidget);
//     expect(find.text('Settings'), findsOneWidget);

//     // Verify initial content on the Home tab.
//     expect(find.text('test@example.com'), findsOneWidget);
//     expect(find.byKey(Key('goBackButton')), findsOneWidget);

//     // Tap on the 'Settings' tab and verify navigation.
//     await tester.tap(find.text('Settings'));
//     await tester.pumpAndSettle(); // Add pumpAndSettle to ensure widget updates

//     // Ensure the widget is visible before checking for presence
//     await tester.ensureVisible(find.text('Settings Page'));

//     // Verify that the SettingsPage is displayed after tapping the 'Settings' tab.
//     expect(find.text('Settings Page'), findsOneWidget);

//     // Tap on the 'Go Back!' button and verify navigation to the Login page.
//     await tester.tap(find.byKey(Key('goBackButton')));
//     await tester.pumpAndSettle();

//     // Verify that Login page is displayed after tapping the 'Go Back!' button.
//     expect(find.text('Login'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttersociallogin/Screens/homePage.dart';

void main() {
  testWidgets('HomePage Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home:
          HomePage(email: 'test@example.com'), // Pass a valid email for testing
    ));

// Inside your testWidgets function
await tester.pumpWidget(MaterialApp(
  home: HomePage(email: 'test@example.com'), // Pass a valid email for testing
));

await tester.pump(Duration(seconds: 2)); // Wait for the widget tree to build

expect(find.text('Home Page'), findsOneWidget);

// Verify initial tab selection.
expect(find.byIcon(Icons.home), findsOneWidget);

// Tap on the second tab (index 1).
await tester.tap(find.byIcon(Icons.home));
await tester.pump();

// Verify the second tab is selected.
expect(find.byIcon(Icons.home), findsOneWidget);

// Tap on the third tab (index 2).
await tester.tap(find.byIcon(Icons.settings));
await tester.pump();

// Verify navigation to SettingsPage.
expect(find.text('Settings Page'), findsOneWidget);

// Verify the presence of email text in the HomePage.
expect(find.text('test@example.com'), findsOneWidget);

  });
}
