import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';

class ErrorManagementProvider extends StatefulWidget {
  final Widget child;

  const ErrorManagementProvider({Key key, @required this.child})
      : super(key: key);
  @override
  _ErrorManagementProviderState createState() =>
      _ErrorManagementProviderState();
}

class _ErrorManagementProviderState extends State<ErrorManagementProvider> {
  ErrorBloc errorBloc;

  @override
  void initState() {
    super.initState();
    errorBloc = ErrorBloc();
  }

  @override
  void dispose() {
    super.dispose();
    errorBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
