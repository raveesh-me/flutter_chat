import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';

class SendToolsRow extends StatefulWidget {
  @override
  _SendToolsRowState createState() => _SendToolsRowState();
}

class _SendToolsRowState extends State<SendToolsRow> {
  TextEditingController _controller = TextEditingController();
  Friend friend;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    friend = ModalRoute.of(context).settings.arguments;
    log("friend: ${friend.toJson()}", name: "SEND TOOLS");
  }

  @override
  Widget build(BuildContext context) {
    if (friend == null) return LoadingScreen();
    return Container();
  }
}
