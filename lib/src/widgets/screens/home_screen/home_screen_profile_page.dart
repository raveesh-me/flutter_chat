import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/profile_bloc.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/widgets/screens/loading_screen.dart';

class HomeScreenProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileBlocModel profileBlocModel = Provider.of<ProfileBlocModel>(context);
    return profileBlocModel == null
        ? LoadingScreen()
        : Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                profileBlocModel.bloc.changeProfile(
                  Profile("id21", "name12", "avatarUrl1234"),
                );
              },
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
                      profileBlocModel.profile.toString(),
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
