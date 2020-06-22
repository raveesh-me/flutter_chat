import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ErrorBlocModel errorBlocModel = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("[${errorBlocModel.originName.toUpperCase()}]"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Spacer(),
            Text(errorBlocModel.errorMessage),
            Spacer(),
            if (errorBlocModel.remedy != null)
              Padding(
                padding: EdgeInsets.all(18),
                child: RaisedButton(
                  onPressed: () {
                    errorBlocModel.remedy();
                  },
                  child: Center(
                    child: Text("${errorBlocModel.remedyLabel}"),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
