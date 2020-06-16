import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

enum LoginState { loggedOut, loggedIn }

class AccountBlocModel {
  final String token;
  final LoginState loginState;
  final AccountBloc bloc;

  AccountBlocModel({
    @required this.token,
    @required this.loginState,
    @required this.bloc,
  });
}

class AccountBloc {
  AccountBlocModel _accountBlocModel;
  set accountBlocModel(AccountBlocModel accountBlocModel) {
    _accountBlocModel = accountBlocModel;
    _accountBlocSubject.add(_accountBlocModel);
  }

  final _accountBlocSubject = BehaviorSubject<AccountBlocModel>();
  Stream<AccountBlocModel> get stream => _accountBlocSubject.stream;

  init() {}

  dispose() {
    _accountBlocSubject.close();
  }
}
