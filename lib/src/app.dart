import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/bloc/profile_bloc.dart';
import 'package:simpleholmuskchat/src/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/screens/root_screen/root_screen.dart';
import 'package:provider/provider.dart';

import 'bloc/account_bloc.dart';
import 'bloc/friends_bloc.dart';
import 'bloc/messages_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

typedef void AppBrightnessToggle();

class _MyAppState extends State<MyApp> {
  /// we are ignoring the platform setting at this point.
  /// we still have to figure out a way to set correct themeData from [MediaQuery.of(context).platformBrightness]
  /// since we are passing theme to materialApp, there is no way to check this setting above material app.
  /// A bug should be filed
  Brightness appBrightness = Brightness.light;

  /// Bloc Responsible for user login state
  AccountBloc accountBloc = AccountBloc();

  /// Bloc responsible for user profile
  ProfileBloc profileBloc = ProfileBloc();

  /// Bloc Responsible for friends
  FriendsBloc friendsBloc = FriendsBloc();

  /// Bloc Responsible for messages with one specific friend
  MessagesBloc messagesBloc = MessagesBloc();

  toggleAppBrightness() {
    setState(() {
      if (appBrightness == Brightness.dark) {
        appBrightness = Brightness.light;
      } else {
        appBrightness = Brightness.dark;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget child) => MultiProvider(
        child: child,
        providers: [
          Provider<AppBrightnessToggle>.value(value: toggleAppBrightness),
          StreamProvider<AccountBlocModel>.value(
            value: accountBloc.stream,
          )
        ],
      ),
      theme: ThemeData(brightness: appBrightness, primarySwatch: Colors.green),
      initialRoute: RootScreen.routeName,
      routes: {
        RootScreen.routeName: (_) => RootScreen(),
        ChatroomScreen.routeName: (_) =>
            ChatroomScreen(friend: ChatroomScreen.friendFromContext(context)),
      },
    );
  }
}
