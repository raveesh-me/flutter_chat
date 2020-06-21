import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/messages_bloc.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/widgets/screens/chatroom_screen/send_tools_row.dart';

import 'message_card.dart';

class ChatroomScreen extends StatefulWidget {
  static final String routeName = "/chatroom";
  static Friend friendFromContext(BuildContext context) {
    // extract from ModalRoute
    Friend friend = ModalRoute.of(context).settings.arguments;
    // if null or not Friend then throw or else return
    if (friend == null)
      throw Exception("Expected an argument of type [Friend]");
    else
      return friend;
  }

  final Friend friend;

  const ChatroomScreen({Key key, @required this.friend}) : super(key: key);

  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  MessagesBlocModel messagesBlocModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    messagesBlocModel = Provider.of<MessagesBlocModel>(context);
    messagesBlocModel.bloc.getMessages(widget.friend.id);
  }

  @override
  void dispose() {
    super.dispose();
    messagesBlocModel.bloc.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.friend.name}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(
                children: messagesBlocModel.messages
                    .map((message) => MessageCard(message: message))
                    .toList(),
              ),
            ),
            SendToolsRow(),
          ],
        ),
      ),
    );
  }
}
