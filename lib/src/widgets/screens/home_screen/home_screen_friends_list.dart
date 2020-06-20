import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/friends_bloc.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/widgets/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';

class HomeScreenFriendsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FriendsBlocModel friendsBlocModel = Provider.of(context);
    if (friendsBlocModel == null)
      return LoadingScreen();
    else
      return ListView(
        children: friendsBlocModel.friends
            .map((Friend friend) => FriendFeatureCard(friend: friend))
            .toList(),
      );
  }
}

class FriendFeatureCard extends StatelessWidget {
  final Friend friend;

  const FriendFeatureCard({Key key, @required this.friend}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ChatroomScreen.routeName,
            arguments: friend,
          );
        },
        child: Card(
          child: Text(
            '${friend.toJson()}',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
