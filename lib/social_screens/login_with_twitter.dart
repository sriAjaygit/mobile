import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginWithTwitter extends StatefulWidget {
  const LoginWithTwitter({Key? key}) : super(key: key);

  @override
  _LoginWithTwitterState createState() => _LoginWithTwitterState();
}

class _LoginWithTwitterState extends State<LoginWithTwitter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with Twitter"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 226, 123, 20),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              signInWithTwitter();
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 226, 123, 20)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ))),
            child: Text("Login With Twitter")),
      ),
    );
  }

  void signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = new TwitterLogin(
        apiKey: 'rmUb1rdhx1F6rMHo0K92PVKkf',
        apiSecretKey: 'AT2wudpdicBmvyzueOOVGshg7EK6iM54pU7WNjGheuBK2ssyKT',
        redirectURI: 'flutter-twitterauth2://');

    // Trigger the sign-in flow
    await twitterLogin.login().then((value) async {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: value.authToken!,
        secret: value.authTokenSecret!,
      );

      await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
    });
  }
}
