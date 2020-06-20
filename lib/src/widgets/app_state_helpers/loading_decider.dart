import 'package:flutter/material.dart';

class LoadingDecider extends StatelessWidget {
  final Widget child;

  const LoadingDecider({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
