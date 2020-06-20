import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/service/api/friends_service.dart';

/// Model with the reference of the Bloc itself that can be injected on top of
/// the render tree
class FriendsBlocModel {
  final List<Friend> friends;
  final FriendsBloc bloc;

  FriendsBlocModel({@required this.friends, @required this.bloc});
}

/// The business logic component responsible for all the functions
class FriendsBloc {
  final FriendsService _friendsService;
  final ErrorBloc errorBloc;
  final AccountBlocModel accountBlocModel;
  FriendsBloc(this._friendsService, this.errorBloc, this.accountBlocModel);

  FriendsBlocModel _friendsBlocModel;
  set _friends(List<Friend> friends) {
    _friendsBlocModel = FriendsBlocModel(friends: friends, bloc: this);
    _friendsBlocSubject.add(_friendsBlocModel);
  }

  final _friendsBlocSubject = BehaviorSubject<FriendsBlocModel>();
  Stream<FriendsBlocModel> get stream => _friendsBlocSubject.stream;

  /// Injecting the service, this makes it easy to deal with environments etc
  init(FriendsService friendsService) async {
    try {
      if (accountBlocModel.token == null ||
          accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      _friends = await _friendsService.getFriends(accountBlocModel.token);
    } catch (e) {
      errorBloc.setError('$e');
    }
  }

  dispose() {
    _friendsBlocSubject.close();
  }
}
