import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(
        message.toString(),
      ),
    );
  }
}
