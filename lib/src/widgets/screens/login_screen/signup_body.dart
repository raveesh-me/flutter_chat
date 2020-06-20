import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';

class SignupBody extends StatelessWidget {
  final Function toggleSignup;

  const SignupBody({
    Key key,
    @required this.toggleSignup,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0).copyWith(bottom: 8),
          child: RaisedButton(
            onPressed:
                Provider.of<AccountBlocModel>(context).bloc.createAccount(
                      "something@somesite.com",
                      "somePassword",
                    ),
            child: Center(child: Text("Signup")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 18),
          child: FlatButton(
            onPressed: toggleSignup,
            child: Text("Login Instead"),
          ),
        ),
      ],
    );
  }
}
