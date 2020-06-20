import 'package:flutter/material.dart';
import 'login_body.dart';
import 'signup_body.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSignup = false;

  toggleSignup() {
    setState(() {
      isSignup = !isSignup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSignup
          ? SignupBody()
          : LoginBody(
              toggleSignup: toggleSignup,
            ),
    );
  }
}
