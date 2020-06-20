import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ErrorBlocModel errorBlocModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("ERROR"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(errorBlocModel.errorMessage)],
        ),
      ),
    );
  }
}
