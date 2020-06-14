import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';

class HomeScreenProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Profile profile = Profile('id', 'name', 'avatarUrl');
    return RefreshIndicator(
      onRefresh: () async {
        log("refreshing...");
        return;
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
