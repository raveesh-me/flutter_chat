import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/friends_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/messages_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/profile_bloc.dart';
import 'package:simpleholmuskchat/src/service/api/friends_service.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/json_friends_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/json_messages_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/json_profile_service.dart';

class AuthenticatedMultiProviderWraper extends StatefulWidget {
  final Widget child;

  const AuthenticatedMultiProviderWraper({Key key, @required this.child})
      : super(key: key);
  @override
  _AuthenticatedMultiProviderWrapperState createState() =>
      _AuthenticatedMultiProviderWrapperState();
}

class _AuthenticatedMultiProviderWrapperState
    extends State<AuthenticatedMultiProviderWraper> {
  FriendsBloc friendsBloc;
  MessagesBloc messagesBloc;
  ProfileBloc profileBloc;
  ErrorBloc errorBloc;
  LoadingBloc loadingBloc;

  AccountBlocModel accountBlocModel;

  //TODO: implement a way to reuse code to get service by [opEnvironment]
  FriendsService getFriendsService() {
    switch (opEnvironment) {
      case OpEnvironments.demo:
        return JsonFriendsService();
        break;
      case OpEnvironments.test:
        return JsonFriendsService();
        break;
      case OpEnvironments.production:
        return FriendsService();
        break;
    }
    throw UnimplementedError();
  }

  MessagesService getMessagesService() {
    switch (opEnvironment) {
      case OpEnvironments.demo:
        return JsonMessagesService();
        break;
      case OpEnvironments.test:
        return JsonMessagesService();
        break;
      case OpEnvironments.production:
        return MessagesService();
        break;
    }
    throw UnimplementedError();
  }

  ProfileService getProfileService() {
    switch (opEnvironment) {
      case OpEnvironments.demo:
        return JsonProfileService();
        break;
      case OpEnvironments.test:
        return JsonProfileService();
        break;
      case OpEnvironments.production:
        return ProfileService();
        break;
    }
    throw UnimplementedError();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    accountBlocModel = Provider.of(context);
    errorBloc = Provider.of<ErrorBlocModel>(context).bloc;
    loadingBloc = Provider.of<LoadingBlocModel>(context).bloc;
    friendsBloc = FriendsBloc(
      errorBloc: errorBloc,
      accountBlocModel: accountBlocModel,
      friendsService: getFriendsService(),
      loadingBloc: loadingBloc,
    );
    messagesBloc = MessagesBloc(
      loadingBloc: loadingBloc,
      accountBlocModel: accountBlocModel,
      errorBloc: errorBloc,
      messagesService: getMessagesService(),
    );
    profileBloc = ProfileBloc(
      errorBloc: errorBloc,
      accountBlocModel: accountBlocModel,
      loadingBloc: loadingBloc,
      profileService: getProfileService(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FriendsBlocModel>.value(
          value: friendsBloc.stream,
        ),
        StreamProvider<MessagesBlocModel>.value(
          initialData: MessagesBlocModel([], messagesBloc),
          value: messagesBloc.stream,
        ),
        StreamProvider<ProfileBlocModel>.value(
          value: profileBloc.stream,
        ),
      ],
      child: widget.child,
    );
  }
}
