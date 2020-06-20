import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/bloc/profile_bloc.dart';
import 'package:simpleholmuskchat/external/widget_test_extensions.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/api/friends_service.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';
import 'package:simpleholmuskchat/src/widgets/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/widgets/screens/root_screen/root_screen.dart';

import 'bloc/account_bloc.dart';
import 'bloc/error_bloc.dart';
import 'bloc/friends_bloc.dart';
import 'bloc/messages_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

typedef void AppBrightnessToggle();

class _MyAppState extends State<MyApp> {
  /// All the app services:
  CreateService createService;
  LoginService loginService;
  FriendsService friendsService;
  MessagesService messagesService;
  ProfileService profileService;

  /// All the app BLoCs
  ErrorBloc errorBloc;
  AccountBloc accountBloc;
  FriendsBloc friendsBloc;
  MessagesBloc messagesBloc;
  ProfileBloc profileBloc;

  initializeServices() {
    createService = CreateService();
    loginService = LoginService();
    friendsService = FriendsService();
    messagesService = MessagesService();
    profileService = ProfileService();
  }

  initializeBlocs() async {
    errorBloc = ErrorBloc();
  }

  /// we are ignoring the platform setting at this point.
  /// we still have to figure out a way to set correct themeData from [MediaQuery.of(context).platformBrightness]
  /// since we are passing theme to materialApp, there is no way to check this setting above material app.
  /// A bug should be filed
  Brightness appBrightness = Brightness.light;
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
      builder: (BuildContext context, Widget child) =>
          child.wrapWithMultiProvider(providers: []),
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
