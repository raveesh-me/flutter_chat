import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
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
  FriendsService _friendsService;
  FriendsBlocModel _friendsBlocModel;
  set _friends(List<Friend> friends) {
    _friendsBlocModel = FriendsBlocModel(friends: friends, bloc: this);
  }

  final _friendsBlocSubject = BehaviorSubject<FriendsBlocModel>();
  Stream<FriendsBlocModel> get stream => _friendsBlocSubject.stream;

  /// Injecting the service, this makes it easy to deal with environments etc
  init(FriendsService friendsService) async {
    _friendsService = friendsService;
    _friends = await _friendsService.getFriends();
  }

  dispose() {
    _friendsBlocSubject.close();
  }
}
