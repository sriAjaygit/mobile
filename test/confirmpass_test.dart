// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:fluttersociallogin/resetPassword.dart';
// import 'package:mockito/mockito.dart';

// import  'package:fluttersociallogin/resetPassword.dart';

// class MockConfirmPassword extends Mock implements ConfirmPassword {}

// void main() {
//   group('ConfirmPassword Widget', () {
//     MockConfirmPassword mockConfirmPassword;

//     setUp(() {
//       mockConfirmPassword = MockConfirmPassword();
//     });

//    testWidgets('should find one TextFormField for password', 
//   (WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         home: ConfirmPassword(title: '', email: ''),
//       ),
//     );

//     expect(find.byType(TextFormField), findsOneWidget);
// });
//         // // Simulate a tap on the reset password button
//         // await tester.tap(find.byType(ElevatedButton));
//         // await tester.pumpAndSettle();

//         // verify(mockConfirmPassword.resetPasswordUser());
//     });
//   });
// }