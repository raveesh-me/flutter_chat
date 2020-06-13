import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/app.dart';

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
        drawer: Drawer(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: Text(
                      "DRAWER",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "DARK MODE:",
                        style: Theme.of(context).textTheme.button,
                      ),
                      Spacer(),
                      Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark ||
                                  MediaQuery.of(context).platformBrightness ==
                                      Brightness.dark,
                          onChanged: (bool switchState) {
                            log('$switchState');
                            Provider.of<AppBrightnessToggle>(context,
                                listen: false)();
                          }),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
