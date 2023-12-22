import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttersociallogin/api_constants.dart';
import 'package:fluttersociallogin/screens/homePage.dart';
import 'package:fluttersociallogin/main.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {
  final String phoneNumber;

  OTPScreen({required this.phoneNumber});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();

  Future<void> verifyOTP(String phoneNumber, String enteredOTP) async {
    try {
      var url = api_constants.verifyOtp +
          "?toPhoneNumber=" +
          phoneNumber +
          "&otp=" +
          enteredOTP;
      final response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        print('OTP verified successfully: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP verified successfully'),
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage(email: '')),
        ); // Replace '/home' with your homepage route
      } else {
        print('Failed to verify OTP: ${response.body}');
        // Handle failure, show error message, etc.
      }
    } catch (error) {
      print('Error verifying OTP: $error');
      // Handle network errors or other exceptions
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
        title: Text('ForgetPassword'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Enter OTP sent to ${widget.phoneNumber}'),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String enteredOTP = otpController.text.toString().trim();
                verifyOTP(widget.phoneNumber, enteredOTP);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(255, 226, 123, 20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}


// class OtpScreen extends StatelessWidget {
//   const OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);

//   final String phoneNumber;

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
// late List<TextEditingController> _otpControllers;
// final TextEditingController _otpController = TextEditingController();

// @override
// void initState() {
//   super.initState();
//   _otpControllers = List.generate(6, (index) => TextEditingController());
// }

// @override
// void dispose() {
//   _otpControllers.forEach((controller) => controller.dispose());
//   super.dispose();
// }
// class OTPScreen extends StatelessWidget {
//   final String phoneNumber;
//   final TextEditingController otpController = TextEditingController();

//   OTPScreen({required this.phoneNumber});
//   Future<void> verifyOTP(String phoneNumber, String enteredOTP) async {
//     try {
//       var url = api_constants.verifyOtp +
//           "?toPhoneNumber=" +
//           phoneNumber +
//           "&otp=" +
//           enteredOTP;
//       final response = await http.post(
//         Uri.parse(url),
//         // body: json.encode({
//         //   'toPhoneNumber': phoneNumber,
//         //   'otp': enteredOTP,
//         // }),
//       );

//       if (response.statusCode == 200) {
//         print('OTP verified successfully: ${response.body}');
//         // Handle success, navigate to the next screen, etc.
//       } else {
//         print('Failed to verify OTP: ${response.body}');
//         // Handle failure, show error message, etc.
//       }
//     } catch (error) {
//       print('Error verifying OTP: $error');
//       // Handle network errors or other exceptions
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Enter OTP'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text('Enter OTP sent to $phoneNumber'),
//             TextField(
//               controller: otpController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Enter OTP'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String enteredOTP = otpController.text.toString().trim();
//                 verifyOTP(phoneNumber, enteredOTP);
//               },
//               child: Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     appBar: AppBar(
  //       backgroundColor: const Color.fromARGB(255, 226, 123, 20),
  //       title: const Text('Registration'),
  //       centerTitle: true,
  //     ),
  //     body: SingleChildScrollView(
  //       reverse: true,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Image.asset(
  //             api_constants.motivityLogo,
  //             height: 75,
  //             width: 200,
  //           ),
  //           SizedBox(height: 20), // Adjust spacing as needed
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               _buildOtpTextField(0),
  //               _buildOtpTextField(1),
  //               _buildOtpTextField(2),
  //               _buildOtpTextField(3),
  //               _buildOtpTextField(4),
  //               _buildOtpTextField(5),
  //             ],
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () {
  //               String enteredOtp = _getEnteredOtp();
  //               // enteredOtp += _otpController
  //               //     .text; // Collect the value from the first text field

  //               // Loop through the rest of the text fields to gather the entered OTP
  //               // for (int i = 1; i < 6; i++) {
  //               //   Key textFieldKey = GlobalKey(debugLabel: "textField$i");
  //               //   TextFormField textField = textFieldKey.currentContext
  //               //       ?.findRenderObject() as TextFormField;
  //               //   enteredOtp += textField.controller?.text ?? "";
  //               // }

  //               if (enteredOtp.length == 6) {
  //                 verifyOtp(widget.phoneNumber, enteredOtp).then((result) {
  //                   if (result.startsWith('OTP verified successfully')) {
  //                     // Navigate to success screen or perform any necessary action
  //                     showSuccessDialog();
  //                   } else {
  //                     // Show error dialog for invalid OTP
  //                     showErrorDialog();
  //                   }
  //                 });
  //               } else {
  //                 showDialog(
  //                   context: context,
  //                   builder: (BuildContext context) {
  //                     return AlertDialog(
  //                       title: Text('Incomplete OTP'),
  //                       content: Text('Please enter the complete 6-digit OTP.'),
  //                       actions: [
  //                         TextButton(
  //                           onPressed: () {
  //                             Navigator.of(context).pop();
  //                           },
  //                           child: Text('OK'),
  //                         ),
  //                       ],
  //                     );
  //                   },
  //                 );
  //               }
  //             },
  //             child: Text('Verify OTP'),

  //             // onPressed: () {
  //             //   if (_otpController.text.length == 0) {
  //             //     verifyOtp(widget.phoneNumber, _otpController.text);
  //             //     Navigator.push(
  //             //         context,
  //             //         MaterialPageRoute(
  //             //             builder: (context) => Login(title: '')));
  //             //   } else {
  //             //     showDialog(
  //             //       context: context,
  //             //       builder: (BuildContext context) {
  //             //         return AlertDialog(
  //             //           title: Text('Incomplete OTP'),
  //             //           content:
  //             //               Text('Please enter the complete 6-digit OTP.'),
  //             //           actions: [
  //             //             TextButton(
  //             //               onPressed: () {
  //             //                 Navigator.of(context).pop();
  //             //               },
  //             //               child: Text('OK'),
  //             //             ),
  //             //           ],
  //             //         );
  //             //       },
  //             //     );
  //             //   }
  //             // },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // String _getEnteredOtp() {
  //   String enteredOtp = '';

  //   for (int i = 0; i < 6; i++) {
  //     enteredOtp += _otpControllers[i].text;
  //   }

  //   return enteredOtp;
  // }

  // Widget _buildOtpTextField(int index) {
  //   return SizedBox(
  //     height: 68,
  //     width: 64,
  //     child: TextFormField(
  //       key: GlobalKey(debugLabel: "textField$index"),
  //       controller: TextEditingController(),
  //       onSaved: (pin) {},
  //       onChanged: (value) {
  //         if (value.length == 1) {
  //           FocusScope.of(context).nextFocus();
  //         }
  //       },
  //       decoration: const InputDecoration(hintText: "0"),
  //       style: Theme.of(context).textTheme.headline6,
  //       keyboardType: TextInputType.number,
  //       textAlign: TextAlign.center,
  //       inputFormatters: [
  //         LengthLimitingTextInputFormatter(1),
  //         FilteringTextInputFormatter.digitsOnly,
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildOtpTextField() {
  //   return SizedBox(
  //     height: 68,
  //     width: 64,
  //     child: TextFormField(
  //       onSaved: (pin) {},
  //       onChanged: (value) {
  //         if (value.length == 1) {
  //           FocusScope.of(context).nextFocus();
  //         }
  //       },
  //       decoration: const InputDecoration(hintText: "0"),
  //       style: Theme.of(context).textTheme.headline6,
  //       keyboardType: TextInputType.number,
  //       textAlign: TextAlign.center,
  //       inputFormatters: [
  //         LengthLimitingTextInputFormatter(1),
  //         FilteringTextInputFormatter.digitsOnly,
  //       ],
  //     ),
  //   );
  // }

  // void showSuccessDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Success!'),
  //         content: Text('OTP Verified Successfully.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.pushNamed(
  //                   context, '/login'); // Navigate to login screen
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void showErrorDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Error'),
  //         content: Text('Invalid OTP. Please try again.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

