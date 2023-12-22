// ignore: file_names
import 'dart:convert'; // Import the 'dart:convert' library for JSON encoding/decoding.

import 'package:flutter/material.dart'; // Import the Flutter Material library.
import 'package:fluttersociallogin/api_constants.dart'; // Import custom API constants.
import 'package:fluttersociallogin/main.dart'; // Import the main.dart file (assuming it contains custom code).
import 'package:http/http.dart'
    as http; // Import the 'http' library for making HTTP requests.
import 'package:http/http.dart'; // Alias for 'http' library for making HTTP requests.

class ConfirmPassword extends StatefulWidget {
  const ConfirmPassword({super.key, required this.title, required this.email});
  final String title;
  final String email;

  get codeController => null;

  get newPasswordController => null;

  get confirmPasswordController => null; 
  @override
  State<StatefulWidget> createState() => _ConfirmPassword();
}

class _ConfirmPassword extends State<ConfirmPassword> {
  TextEditingController emailcontroller =
      TextEditingController(); // Create a text controller for email input.
  TextEditingController codeController =
      TextEditingController(); // Create a text controller for code input.
  TextEditingController newPasswordController =
      TextEditingController(); // Create a text controller for new password input.
  TextEditingController confirmPasswordController = TextEditingController();

  void resetPasswordUser() async {
    // Define a function to reset the user's password.
    // var url = "http://172.20.100.13:7071/api/user/resetpassword";  // Commented out URL definition.
    var data = {
      "email": emailcontroller.text,
      "changePasswordId": codeController.text,
      "newPassword": newPasswordController.text,
    }; // Create a map 'data' to hold user data.
    var body = json.encode(data); // Encode 'data' as a JSON string.
    var urlParse = Uri.parse(api_constants
        .resetpassword); // Parse the API endpoint URL from custom constants.

    try {
      Response response = await http.post(
        // Send a POST request to the API endpoint.
        urlParse,
        body: body, // Send JSON-encoded user data in the request body.
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        // Check if the response status code is 200 (success).
        print("PasswordReset successful. Server response: ");
      } else {
        print(
            "Registration failed. Status code:"); // Print an error message if the response status code is not 200.
      }
    } catch (e) {
      print(
          "An error occurred: $e"); // Handle and print any exceptions that occur during the request.
    }
    // print(response.body);  // Commented out response.body printing.
  }

  // Validate that the new password and confirm password match

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Build a Flutter scaffold for the user interface.
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 123, 20),
          title: Text('Reset Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // Create a scrollable view for the form.
          reverse: true,
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: 16.0, horizontal: 16.0),
              //   child: TextField(
              //     controller: emailcontroller,
              //     decoration: const InputDecoration(
              //         border: OutlineInputBorder(), hintText: 'Enter email'),
              //   ), // Create a text input field for email.
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: TextFormField(
                  controller: codeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'enter code',
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter your code';
                  //   }
                  //   return null;
                  // },
                ), // Create a text input field for code input with validation.
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: TextFormField(
                    controller: newPasswordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter new Password',
                    ),
                    validator: validatePassword,
                    // if (value == null || value.isEmpty) {
                    //   return 'Please enter Password';
                    // }
                    // return null;
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'confirm Password',
                  ),
                  // validator: (value) => validatePasswordConfirmation(
                  //     value!, newPasswordController.text),
                  // autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter the password';
                    }
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return validatePassword(value);
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ), // Create a text input field for a new password with validation.
              ElevatedButton(
                onPressed: () {
                  // if (validatePasswordConfirmation(
                  //         confirmPasswordController.text, '') ==
                  //     null) {
                  //   resetPasswordUser();
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const Login(title: '')),
                  //   );
                  // } else {}
                  String? passwordError =
                      validatePassword(newPasswordController.text);
                  String? confirmPasswordError = validatePasswordConfirmation(
                      confirmPasswordController.text);

                  if (passwordError == null && confirmPasswordError == null) {
                    resetPasswordUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(title: ''),
                      ),
                    );
                  } else {
                    // Display password validation error if exists
                    if (passwordError != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(passwordError),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }

                    // Display confirm password validation error if exists
                    if (confirmPasswordError != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(confirmPasswordError),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },

                // resetPasswordUser(); // Call the 'resetPasswordUser' function when the button is pressed.
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => const Login(title: '')),
                // ); // Navigate to the Login screen after the button is pressed.

                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 226, 123, 20)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ))),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ), // Create an elevated button for submitting the form.
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom))
            ],
          ),
        ));
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  String? validatePasswordConfirmation(String value) {
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

    RegExp regExp = RegExp(
        r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+,\./\\-])\S{8,}$');

    if (!regExp.hasMatch(value)) {
      return 'Password must be at least 8 characters with no spaces';
    }
    return null;
  }
}
