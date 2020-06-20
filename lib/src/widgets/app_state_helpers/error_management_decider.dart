import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';

class ErrorManagementDecider extends StatelessWidget {
  final Widget errorScreen;
  final Widget child;

  const ErrorManagementDecider(
      {Key key, @required this.errorScreen, @required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ErrorBlocModel errorBlocModel = Provider.of<ErrorBlocModel>(context);
    return errorBlocModel?.hasError ?? false ? errorScreen : child;
  }
}
