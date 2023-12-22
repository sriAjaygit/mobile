// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttersociallogin/api_constants.dart';
import 'package:fluttersociallogin/main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
// import 'package:http/http.dart';

// import 'package:fluttersociallogin/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    required this.title,
    required String email,
  });
  final String title;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formkey = GlobalKey<FormState>();
  bool _validate = false;
  bool userExists = false;
  String namePattern = r'^[a-zA-Z]+$';
  String passwordPattern =
      r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+,\./\\-]).{8,}$';
  String phoneNumberPattern = r'^([6-9])(?!\1{9})[0-9]{9}$';

  // ignore: unused_field
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  String saticCountryCode = '+91';
  String staticRole = 'USER';

  void registerUser() async {
    // Validate password length on the client side

    // var url = "http://172.20.100.13:7071/api/user/register";
    var data = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "emailAddress": emailController.text,
      "password": passwordController.text,
      "contactNumber": contactNumberController.text,
      "countryCode": saticCountryCode,
      "role": staticRole,
    };

    var bodyy = json.encode(data);
    var urlParse = Uri.parse(api_constants.register);
    Response response;
    try {
      response = await http.post(urlParse,
          body: bodyy, headers: {"Content-Type": "application/json"});
      if (response.statusCode == 201) {
        var responseData = jsonDecode(response.body);
        print("Registration was successful.Server respone: $responseData");

        // Show success message using SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(
                seconds: 2), // You can customize the duration as needed
          ),
        );
      } else if (response.statusCode == 500) {
        var responseMessage = response.body.toString().toLowerCase();
        if (responseMessage.contains(' already exists')) {
          setState(() {
            userExists = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('user already exists login with other credentials'),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          // Show error message without navigating to the login page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text('Login unsuccessful. Please enter valid credentials.'),
            ),
          );
        }
      } else {
        print("Registration failed. Status code: ${response.statusCode}");
        print("Response: ${response.body}");
      }
    } catch (e) {
      print("An error occured: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 226, 123, 20),
          title: const Text('Registration'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            reverse: true,
            child: Form(
              key: formkey,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: TextFormField(
                      key: const Key('firstName'),
                      controller: firstNameController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: 'FirstName',
                          hintText: 'Enter your first name'),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your first name';
                      //   } else {
                      //     return null;
                      //   }
                      // },

                      validator: (value) => validateName(value!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: TextFormField(
                      controller: lastNameController,
                      // obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'LastName',
                        hintText: 'Enter your last name',
                      ),
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your lastname';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                      validator: (value) => validateName(value!),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your email',
                        ),
                        // validator: (value) {
                        //   print("Inside validation");
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your password';
                        //   }
                        //   return null;
                        // },
                        // autovalidateMode: AutovalidateMode.onUserInteraction,

                        validator: (value) => validateEmail(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: "Email",
                          hintText: 'Enter your Password',
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your password';
                        //   }
                        //   return null;
                        // },
                        validator: (value) => validatePassword(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        controller: contactNumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: "Email",
                          hintText: 'Enter your PhoneNumber',
                        ),
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your PhoneNumber';
                        //   }
                        //   return null;
                        // },

                        validator: (value) => validatePhoneNumber(value!),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      )),
                  ElevatedButton(
                    onPressed: () async {
                      // Check if the form is valid
                      if (formkey.currentState?.validate() == true) {
                        // Form is valid, proceed with registration
                        registerUser();
                        if (!userExists) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(title: ''),
                            ),
                          );
                        }
                        // Wait for a short duration before navigating
                        // await Future.delayed(const Duration(milliseconds: 500));

                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(
                        //     content: Text('Registration successful!'),
                        //     duration: Duration(seconds: 2),
                        //   ),
                        // );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const Login(title: ''),
                        //   ),
                        // );
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 226, 123, 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        // Your button style
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            )));
  }

  String? validateEmail(String value) {
    String emailPattern = r'@.*\.com$';
    RegExp regExp = RegExp(emailPattern);

    if (!regExp.hasMatch(value)) {
      return 'please enter email address';
    }
  }

  String? validateName(String value) {
    RegExp regExp = RegExp(namePattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }
  }

  String? validatePassword(String value) {
    RegExp regExp = RegExp(passwordPattern);

    if (!regExp.hasMatch(value)) {
      return 'Password must be at least 10 characters ';
    }
  }

  String? validatePhoneNumber(String value) {
    RegExp regExp = RegExp(phoneNumberPattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
  }
}
