import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';

class LoginBody extends StatelessWidget {
  final Function toggleSignup;

  const LoginBody({
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
            onPressed: () =>
                Provider.of<AccountBlocModel>(context, listen: false)
                    .bloc
                    .login(
                      "something@somesite.com",
                      "somepassword",
                    ),
            child: Center(child: Text("LOGIN")),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0).copyWith(bottom: 18),
          child: FlatButton(
            onPressed: toggleSignup,
            child: Text("Signup Instead"),
          ),
        ),
      ],
    );
  }
}
