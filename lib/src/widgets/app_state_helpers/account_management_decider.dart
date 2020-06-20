import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';

class AccountManagementDecider extends StatelessWidget {
  final Widget loggedInScreen;
  final Widget loggedOutScreen;

  const AccountManagementDecider(
      {Key key, @required this.loggedInScreen, @required this.loggedOutScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountBlocModel accountBlocModel = Provider.of(context);
    if (accountBlocModel.loginState == LoginState.loggedOut)
      return loggedOutScreen;
    else
      return loggedInScreen;
  }
}
