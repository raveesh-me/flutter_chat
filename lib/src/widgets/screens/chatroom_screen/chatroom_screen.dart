import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/widgets/screens/chatroom_screen/send_tools_row.dart';

class ChatroomScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${friend.name}'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView(),
            ),
            SendToolsRow(),
          ],
        ),
      ),
    );
  }
}
