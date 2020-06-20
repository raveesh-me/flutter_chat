import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;

  const LoadingWrapper({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<LoadingBlocModel>(context)?.isLoading ?? true;
    return isLoading ? LoadingScreen() : child;
  }
}
