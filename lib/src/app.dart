import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/widgets/app_state_helpers/account_management_decider.dart';
import 'package:simpleholmuskchat/src/widgets/app_state_helpers/account_management_provider.dart';
import 'package:simpleholmuskchat/src/widgets/app_state_helpers/authenticated_multi_provider_wrapper.dart';
import 'package:simpleholmuskchat/src/widgets/app_state_helpers/error_management_decider.dart';
import 'package:simpleholmuskchat/src/widgets/app_state_helpers/error_management_provider.dart';
import 'package:simpleholmuskchat/src/widgets/screens/chatroom_screen/chatroom_screen.dart';
import 'package:simpleholmuskchat/src/widgets/screens/error_screen/error_screen.dart';
import 'package:simpleholmuskchat/src/widgets/screens/login_screen/login_screen.dart';
import 'package:simpleholmuskchat/src/widgets/screens/root_screen/root_screen.dart';

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
      builder: (BuildContext context, Widget child) => ErrorManagementProvider(
        child: ErrorManagementDecider(
          errorScreen: ErrorScreen(),
          child: AccountManagementProvider(
            child: AccountManagementDecider(
              loggedInScreen: AuthenticatedMultiProviderWraper(child: child),
              loggedOutScreen: LoginScreen(),
            ),
          ),
        ),
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
