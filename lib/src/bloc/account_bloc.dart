import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';

const AUTH_TOKEN_KEY = "auth_token";
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
  final LoginService loginService;
  final CreateService createService;

  AccountBlocModel _accountBlocModel;

  /// we need these services, initialized, to be able to perform activities
  AccountBloc(this.loginService, this.createService);

  set accountBlocModel(AccountBlocModel accountBlocModel) {
    _accountBlocModel = accountBlocModel;
    _accountBlocSubject.add(_accountBlocModel);
  }

  final _accountBlocSubject = BehaviorSubject<AccountBlocModel>();
  Stream<AccountBlocModel> get stream => _accountBlocSubject.stream;

  init() async {
    accountBlocModel = AccountBlocModel(
        token: null, loginState: LoginState.loggedOut, bloc: this);
    // fetch the token from shared preferences
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    final token = _preferences.getString(AUTH_TOKEN_KEY);
    if (token == null) return;
  }

  login() {}

  dispose() {
    _accountBlocSubject.close();
  }
}
