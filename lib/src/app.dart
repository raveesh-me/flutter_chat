import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/screens/root_screen/root_screen.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

typedef void AppBrightnessToggle();

class _MyAppState extends State<MyApp> {
  /// we are ignoring the platform setting at this point.
  /// we still have to figure out a way to set correct themeData from [MediaQuery.of(context).platformBrightness]
  /// since we are passing theme to materialApp, there is no way to check this setting above material app.
  ///
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
      builder: (BuildContext context, Widget child) => MultiProvider(
        child: child,
        providers: [
          Provider<AppBrightnessToggle>.value(value: toggleAppBrightness)
        ],
      ),
      theme: ThemeData(brightness: appBrightness),
      initialRoute: RootScreen.routeName,
      routes: {
        RootScreen.routeName: (_) => RootScreen(),
        ChatroomScreen.routeName: (_) =>
            ChatroomScreen(friend: ChatroomScreen.friendFromContext(context)),
      },
    );
  }
}
