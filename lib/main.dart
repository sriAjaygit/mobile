import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttersociallogin/Screens/OtpScreen.dart';
import 'package:fluttersociallogin/api_constants.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttersociallogin/Screens/forgot_password.dart';
import 'package:fluttersociallogin/Screens/homePage.dart';
import 'package:fluttersociallogin/social_screens/loginWithFacebook.dart';
import 'package:fluttersociallogin/provider/GoogleSign_in_provider.dart';
import 'package:fluttersociallogin/Screens/signup.dart';
import 'package:fluttersociallogin/social_screens/loginWithGoogle.dart';
import 'package:fluttersociallogin/social_screens/login_with_twitter.dart';
import 'package:fluttersociallogin/theme/theme_constants.dart';
import 'package:fluttersociallogin/theme/theme_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  //initialize the application

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // TODO: implement dispose
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: Login(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({
    super.key,
    required this.title,
  });
  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // LoginWithTwitter loginWithTwitter = LoginWithTwitter();
  LoginWithFacebook loginWithFacebook = LoginWithFacebook();
  SignUp signUp = SignUp(title: '', email: '');

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // void nextScreen(context, Page) {
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => Page));
  // }

  void loginUser() async {
    var url = "http://172.20.100.13:7071/api/user/login";
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    var bodyy = json.encode(data);
    var urlParse = Uri.parse(url);
    try {
      Response response = await http.post(urlParse,
          body: bodyy, headers: {"Content-Type": "application/json"});
      print(response.body);
      if (response.statusCode == 200) {
        // Successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              email: emailController.text,
            ),
          ),
        );
        showSuccessDialog(context);
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(title: ''),
            )); // Unsuccessful login
        showErrorDialog(
          context,
          "Invalid credentials. Please try again.",
        );
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      showErrorDialog(
        context,
        "An error occurred. Please try again later.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 226, 123, 20),
            title: Text("Login"),
            centerTitle: true),
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      // 'assets/images/MotivityLogo.jpg',
                      api_constants.motivityLogo,
                      height: 75,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: TextFormField(
                      controller: passwordController,
                      // obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => forgot_password(
                                  email: emailController.text,
                                ),
                              ),
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 226, 123, 20)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ))),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              // Your button style
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 50), // Adjust the spacing as needed
                        ElevatedButtonTheme(
                            data: ElevatedButtonThemeData(
                                style: ElevatedButton.styleFrom(
                                    maximumSize: const Size(140, 40))),
                            child: ButtonBar(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    loginUser();
                                    // Handle the second button's action here
                                    if (_formKey.currentState!.validate()) {
                                      if (emailController.text != "" &&
                                          passwordController.text != "") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage(
                                                    email: emailController.text,
                                                  )),
                                        );

                                        showSuccessDialog(context);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Invalid Credentials')),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text('Please fill input')),
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 226, 123, 20)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ))),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // Your button style
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                  //   child: Center(
                  //       child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => SignUp(
                  //                   email: emailController.text,
                  //                 )),
                  //       );
                  //     },
                  //     child: const Text('Sign Up'),
                  //   )),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10.0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(
                                  title: '',
                                  email: emailController.text,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Dont have an account?',
                            style: TextStyle(
                              color: Colors.black,
                              // Your button style
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 10), // Adjust the spacing as needed

                        ElevatedButtonTheme(
                            data: ElevatedButtonThemeData(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(140, 40))),
                            child: ButtonBar(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle the second button's action here
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(
                                          email: emailController.text,
                                          title: '',
                                        ),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 226, 123, 20)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ))),
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // Your button style
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: double.infinity, // Full-width container
                    height: 30.0, // Adjust the height as needed
                    decoration: const BoxDecoration(
                      color: Colors.red, // Container background color
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .transparent, // Set button background to transparent
                        onPrimary: Colors.transparent,
                        minimumSize: const Size(double.infinity, 40),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.google,
                          color: Colors.white),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginWithGoogle()));

                        // final provider = Provider.of<GoogleSignInProvider>(
                        //     context,
                        //     listen: false);
                        // provider.googleLogin(context);
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    width: double.infinity, // Full-width container
                    height: 30.0, // Adjust the height as needed
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Container background color
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .transparent, // Set button background to transparent
                        onPrimary: Colors.transparent,
                        minimumSize: const Size(double.infinity, 20),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.facebook,
                          color: Colors.white),
                      label: const Text(
                        'Sign in with Facebook',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginWithFacebook()));

                        // loginWithFacebook.signInWithFacebook();
                      },
                    ),
                  ),

                  SizedBox(height: 15),

                  Container(
                    width: double.infinity, // Full-width container
                    height: 30.0, // Adjust the height as needed
                    decoration: const BoxDecoration(
                      color: Colors.blue, // Container background color
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .transparent, // Set button background to transparent
                        onPrimary: Colors.transparent,
                        minimumSize: const Size(double.infinity, 20),
                      ),
                      icon: const FaIcon(FontAwesomeIcons.twitter,
                          color: Colors.white),
                      label: const Text(
                        'Sign in with Twitter',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginWithTwitter()));

                        // loginWithTwitter.signInWithTwitter();
                      },
                    ),
                  ),

                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          ),
        ));
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Successful"),
          content: Text("You have successfully logged in!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login Failed"),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
