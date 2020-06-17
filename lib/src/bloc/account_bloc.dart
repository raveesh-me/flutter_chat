import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
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
  final ErrorBloc errorBloc;
  SharedPreferences _preferences;

  AccountBlocModel _accountBlocModel;

  /// we need these services, initialized, to be able to perform activities
  AccountBloc(this.loginService, this.createService, this.errorBloc) {
    init();
  }

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
    _preferences = await SharedPreferences.getInstance();
    final token = _preferences.getString(AUTH_TOKEN_KEY);
    if (token == null)
      return;
    else
      accountBlocModel = AccountBlocModel(
          token: token, loginState: LoginState.loggedIn, bloc: this);
  }

  login(String email, String password) async {
    final newToken = await loginService.signInGetToken(email, password);
    _preferences.setString(AUTH_TOKEN_KEY, newToken);
    accountBlocModel = AccountBlocModel(
        token: newToken, loginState: LoginState.loggedIn, bloc: this);
  }

  createAccount(String email, String password) async {
    final newToken =
        await createService.createAccountAndGetToken(email, password);
    _preferences.setString(AUTH_TOKEN_KEY, newToken);
    accountBlocModel = AccountBlocModel(
        token: newToken, loginState: LoginState.loggedIn, bloc: this);
  }

  logoutAndDeleteData() async {
    final signedOut =
        await loginService.signOutAndDelete(_accountBlocModel.token);
    final clearedPreference = await _preferences.clear();
    if (!(signedOut && clearedPreference))
      errorBloc.setError("Could not log out\nRestart app and try again");
    accountBlocModel = AccountBlocModel(
        token: null, loginState: LoginState.loggedOut, bloc: this);
  }

  dispose() {
    _accountBlocSubject.close();
  }
}
