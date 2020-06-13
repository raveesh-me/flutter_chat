import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_bottom_nav_bar.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_drawer.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_friends_list.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_profile_page.dart';

enum NavigablePage { list, me }

class HomeScreen extends StatefulWidget {
  static final routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NavigablePage navigablePage;

  @override
  void initState() {
    super.initState();
    navigablePage = NavigablePage.list;
  }

  @override
  void dispose() {
    super.dispose();
  }

  onBottomNavigationTap(int i) {
    log('$i');
    setState(() {
      navigablePage = NavigablePage.values[i];
    });
    log('$navigablePage');
  }

  getScreenByNavigablePage(NavigablePage navigablePage) {
    Widget widget;
    switch (navigablePage) {
      case NavigablePage.list:
        return HomeScreenFriendsList();
        break;
      case NavigablePage.me:
        return HomeScreenProfilePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              navigablePage.toString().split('.')[1].toUpperCase(),
            ),
          ),
          drawer: Drawer(child: HomeScreenDrawer()),
          bottomNavigationBar: HomeScreenBottomNavBar(
            onBottomNavigationTap: onBottomNavigationTap,
            currentIndex: NavigablePage.values.indexOf(navigablePage),
          ),
          body: Center(
            child: getScreenByNavigablePage(navigablePage),
          )),
    );
  }
}
