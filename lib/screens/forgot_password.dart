import 'package:flutter/material.dart'; // Import the Flutter Material library.
import 'package:fluttersociallogin/Screens/OtpScreen.dart';
import 'package:fluttersociallogin/Screens/resetPassword.dart'; // Import the ConfirmPassword class from another file.
import 'package:fluttersociallogin/api_constants.dart'; // Import custom API constants.
import 'package:http/http.dart'
    as http; // Import the 'http' library for making HTTP requests.

// ignore: must_be_immutable
class forgot_password extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String email;
  late String enteredValue; // Declare a variable to store the user's email.
  static const String id = 'ForgotPassword';
  //  String phoneNumber = '911234567890';// Create a unique identifier for the screen.

  forgot_password(
      {super.key,
      required String email}); // Constructor for the forgot_password class.

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController inputController = TextEditingController();
  String staticphoneNumber = '+91';

  get context => null; // Create a text controller for email input.

  @override
  Widget build(BuildContext context) {
    String email = emailcontroller.text;
    return Scaffold(
        // Build a Flutter scaffold for the user interface.
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 123, 20),
          title: const Text('Forget Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            // Create a scrollable view for the form.
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        api_constants.motivityLogo,
                        height: 75,
                        width: 200,
                      ),
                    ), // Display an image from custom constants.
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        controller: inputController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your email or phone number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter your email or phone number';
                          }
                          // if (!isValidEmail(value) &&
                          //     !_isValidPhoneNumber(value)) {
                          //   return 'Please enter a valid email or phone number';
                          // }
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      // onPressed: () {
                      //   String input = inputController.text.trim();

                      //   if (input.contains('@')) {
                      //     resetPassword(input);
                      //     // Email entered, navigate to ConfirmPasswordScreen
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             ConfirmPassword(email: input, title: ''),
                      //       ),
                      //     );
                      //   } else {

                      //     // Phone number entered, navigate to OTPScreen
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             OTPScreen(phoneNumber: input),
                      //       ),
                      //     );
                      //   }
                      // },

                      onPressed: () async {
                        String input = inputController.text.trim();
                        if (input.isNotEmpty) {
                          if (isValidEmail(input)) {
                            await resetPassword(input);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmPassword(
                                  email: input,
                                  title: '',
                                ),
                              ),
                            );
                          } else if (_isValidPhoneNumber(input)) {
                            // Add logic here to call sendOtp() function
                            await sendOtp(input);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OTPScreen(phoneNumber: input),
                              ),
                            );
                          } else {
                            // Handle invalid input (neither email nor phone number)
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Invalid Input'),
                                  content: Text(
                                      'Please enter a valid email or phone number.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        } else {
                          // Handle empty input
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Empty Input'),
                                content: Text(
                                    'Please enter your email or phone number.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );   
                            },
                          );
                        }
                      },

                      //   onPressed: () {
                      //     String input = inputController.text.trim();
                      //     if (input.isNotEmpty) {
                      //       navigateToNextScreen(context, input);
                      //     } else {
                      //       // Handle empty input
                      //       // You can show a snackbar or an alert dialog here
                      //     }
                      //   },

                      // onPressed: () {
                      //   // if (isValidEmail(email)) {
                      //   //   print(email);
                      //   //   resetPassword(email);

                      //   if (_formKey.currentState!.validate()) {
                      //     final enteredEmail = emailcontroller.text;
                      //     resetPassword(enteredEmail);

                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ConfirmPassword(
                      //                 title: 'forgot password',
                      //                 email: enteredEmail,
                      //               )),
                      //     ); // Navigate to the ConfirmPassword screen after the button is pressed.
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           title: Text('Email Sent'),
                      //           content: Text(
                      //               'Reset password link has been sent to your email'),
                      //           actions: <Widget>[
                      //             TextButton(
                      //               child: Text('OK'),
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   } // Display a confirmation dialog.
                      // },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 226, 123, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ))),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          // Your button style
                        ),
                      ),
                    ), // Create an elevated button for submitting the form.
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ))));
  }

  Future<void> resetPassword(String email) async {
    // Define a function to reset the user's password.
    // final apiEndpoint = 'http://172.20.100.13:7071/api/user/forgotpassword';  // Commented out API endpoint.

    final requestData = {
      'loginId': email,
    }; // Create a map 'requestData' to hold user data.
    try {
      final response = await http.post(
        Uri.parse(api_constants.forgotpassword),
        body: requestData,
      ); // Send a POST request to the API endpoint.
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (success).
        print("ResetPAssword link sent successfully. Server response:");
      } else {
        print(
            "Failed to reset password"); // Print an error message if the response status code is not 200.
      }
    } catch (e) {
      print(
          "An error occurred: $e"); // Handle and print any exceptions that occur during the request.
    }
    // print(response.body);  // Commented out response.body printing.
  }

  // Future<void> generateOTP(String phoneNumber) async {
  //   final OtpEndpoint = {
  //     'toPhoneNumber': phoneNumber,
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(api_constants.sendOtp),
  //       body: OtpEndpoint,
  //     );
  //     if (response.statusCode == 200) {
  //       // Assuming the API responds with success when OTP is generated
  //       print("ResetPAssword link sent successfully. Server response:");
  //     }
  //     else{
  //       print(
  //           "Failed to reset password");
  //     }
  //   } catch (e) {
  //     print('Error generating OTP: $e');
  //     return false;
  //   }
  // }

  // Regular expression for email validation
  bool isValidEmail(String value) {
    // Simple email validation pattern
    final emailRegex = RegExp(r'^\+\d{1,3}\d{10}$');
    return emailRegex.hasMatch(value);
  }

  bool _isValidPhoneNumber(String value) {
    // Implement your phone number validation logic here
    // For simplicity, you can check the length or use a regex pattern
    return value.length == 12; // Example: Check for 10-digit phone number
  }

  String phoneNumberPattern = r'^\91\d{10}$';
  String? validatePhoneNumber(String value) {
    RegExp regExp = RegExp(phoneNumberPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
  }

  Future<String> sendOtp(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse(api_constants.sendOtp),
        body: {'toPhoneNumber': phoneNumber},
      );

      if (response.statusCode == 200) {
        return 'OTP sent successfully.';
      } else {
        return 'Failed to send OTP. Please try again.';
      }
    } catch (e) {
      return 'Error sending OTP: $e';
    }
  }

  // void navigateToNextScreen(BuildContext context, String input) {
  //   if (input.contains('@')) {
  //     // Check if input contains '@' assuming it's an email
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => ConfirmPassword(
  //           email: input,
  //           title: '',
  //         ),
  //       ),
  //     );
  //   } else {
  //     // Assume it's a phone number and navigate to OTP screen
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => OtpScreen(phoneNumber: input),
  //       ),
  //     );
  //   }
  // }
}
