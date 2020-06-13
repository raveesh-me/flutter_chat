import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/screens/root_screen/root_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: RootScreen.routeName,
      routes: {
        RootScreen.routeName: (_) => RootScreen(),
        ChatroomScreen.routeName: (_) =>
            ChatroomScreen(friend: ChatroomScreen.friendFromContext(context)),
      },
    );
  }
}
