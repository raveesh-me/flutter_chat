import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
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
  final ErrorBloc _errorBloc;
  final AccountBlocModel _accountBlocModel;
  final LoadingBloc _loadingBloc;

  FriendsBlocModel _friendsBlocModel;
  set _sFriends(List<Friend> friends) {
    _friendsBlocModel = FriendsBlocModel(friends: friends, bloc: this);
    _subject.add(_friendsBlocModel);
  }

  final _subject = BehaviorSubject<FriendsBlocModel>();
  Stream<FriendsBlocModel> get stream => _subject.stream;

  FriendsBloc({
    @required FriendsService friendsService,
    @required ErrorBloc errorBloc,
    @required AccountBlocModel accountBlocModel,
    @required LoadingBloc loadingBloc,
  })  : this._errorBloc = errorBloc,
        this._accountBlocModel = accountBlocModel,
        this._friendsService = friendsService,
        this._loadingBloc = loadingBloc {
    _sFriends = [];
    init();
  }

  init() async {
    _loadingBloc.startLoading();
    try {
      if (_accountBlocModel.token == null ||
          _accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      _sFriends = await _friendsService.getFriends(_accountBlocModel.token);
    } catch (e) {
      _errorBloc.setError('$e');
    } finally {
      _loadingBloc.stopLoading();
    }
  }

  dispose() {
    _subject.close();
  }
}
