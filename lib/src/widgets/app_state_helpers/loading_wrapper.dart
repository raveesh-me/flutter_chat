import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;

  const LoadingWrapper({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoadingBlocModel loadingBlocModel = Provider.of(context);
    log('$loadingBlocModel');
//    bool isLoading = Provider.of<LoadingBlocModel>(context).isLoading;
//    log('$isLoading');
//    return isLoading ? LoadingScreen() : child;
    return Scaffold(
      body: LoadingScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          loadingBlocModel.bloc.startLoading();
        },
      ),
    );
  }
}
