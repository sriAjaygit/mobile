// // import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttersociallogin/main.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   TextEditingController emailController = TextEditingController();

//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;

//   Future googleLogin(BuildContext context) async {
//     try {
//       final googleUSer = await googleSignIn.signIn();
//       if (googleUSer == null) return;
//       _user = googleUSer;

//       final googleAuth = await googleUSer.authentication;

//       final Credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//       await FirebaseAuth.instance.signInWithCredential(Credential);
//       return _user;

//       // Navigator.of(context).pushReplacement(
//       //     MaterialPageRoute(builder: (context) => HomePage(email: '')));
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(email: emailController.text),
//         ),
//         (route) => false,
//       );
//       notifyListeners();
//     } catch (e, stackTrace) {
//       // Log and print any errors
//       print("Error during login: $e");
//       print("StackTrace: $stackTrace");
//     }
//   }

//   Future<void> googleSignOut() async {
//     try {
//       if (googleSignIn.currentUser != null) {
//         print("Signing out from Google");
//         await googleSignIn.signOut();
//       } else {
//         print("Google user is not signed in");
//       }
//       print("Signing out from firebase");
//       await FirebaseAuth.instance.signOut();
//       _user = null;
//       notifyListeners();
//       print("Sign-out successful");
//     } catch (e, stackTrace) {
//       // Log and print any errors
//       print("Error during sign-out: $e");
//       print("StackTrace: $stackTrace");
//     }
//   }
// }
