import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';

class HomeScreenProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Profile profile = Provider.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Edit"),
        icon: Icon(Icons.edit),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          log("refreshing...");
          return;
        },
        child: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: [
            CircleAvatar(
              child: Placeholder(),
              maxRadius: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                profile.toString(),
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
