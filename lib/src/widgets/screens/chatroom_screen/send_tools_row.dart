import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/messages_bloc.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';
import 'package:image_picker/image_picker.dart';

class SendToolsRow extends StatefulWidget {
  @override
  _SendToolsRowState createState() => _SendToolsRowState();
}

class _SendToolsRowState extends State<SendToolsRow> {
  TextEditingController _controller = TextEditingController();
  Friend friend;
  final picker = ImagePicker();
  MessagesBlocModel messagesBlocModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    friend = ModalRoute.of(context).settings.arguments;
    messagesBlocModel = Provider.of<MessagesBlocModel>(context);
  }

  sendTextMessage() async {
    if (_controller.text == null)
      return;
    else
      await messagesBlocModel.bloc
          .sendMessage(friend.id, Message(_controller.text));
  }

  sendImage() async {
    // fetch image using the plugin
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final File image = File(pickedFile.path);
    await messagesBlocModel.bloc.sendMessage(
      friend.id,
      Message(null, image.readAsBytesSync()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (friend == null) return LoadingScreen();
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.image),
          onPressed: sendImage,
        ),
        Expanded(
          child: TextField(
            controller: _controller,
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: sendTextMessage,
        )
      ],
    );
  }
}
