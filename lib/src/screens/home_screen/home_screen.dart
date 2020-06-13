import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/screens/home_screen/home_screen_drawer.dart';

enum NavigablePages { list, me }

class HomeScreen extends StatefulWidget {
  static final routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "List",
          ),
        ),
        drawer: Drawer(child: HomeScreenDrawer()),
      ),
    );
  }
}
