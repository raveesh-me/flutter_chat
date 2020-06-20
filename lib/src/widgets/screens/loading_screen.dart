import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.black),
        )
      ],
    );
  }
}
