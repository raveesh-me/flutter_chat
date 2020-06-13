import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class HomeScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "DARK MODE:",
                  style: Theme.of(context).textTheme.button,
                ),
                Spacer(),
                Switch(
                    value: Theme.of(context).brightness == Brightness.dark ||
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
            Padding(
              padding: const EdgeInsets.all(28.0).copyWith(left: 0),
              child: InkWell(
                  onTap: () {},
                  child: Text(
                    "LOGOUT",
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .caption
                        .copyWith(fontSize: 25),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
