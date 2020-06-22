import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
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

  @override
  String toString() => '''
  AccountBlocModel: {
  loginState: $loginState,
  token: $token
  }
  ''';
}

class AccountBloc {
  final LoginService _loginService;
  final CreateService _createService;
  final ErrorBloc _errorBloc;
  final LoadingBloc _loadingBloc;
  SharedPreferences _preferences;

  AccountBlocModel _accountBlocModel;
  set _sAccountBlocModel(AccountBlocModel accountBlocModel) {
    _accountBlocModel = accountBlocModel;
    _subject.add(_accountBlocModel);
  }

  final _subject = BehaviorSubject<AccountBlocModel>();
  Stream<AccountBlocModel> get stream => _subject.stream;

  /// we need these services, initialized, to be able to perform activities
  AccountBloc({
    @required LoginService loginService,
    @required CreateService createService,
    @required ErrorBloc errorBloc,
    @required LoadingBloc loadingBloc,
  })  : this._loginService = loginService,
        this._createService = createService,
        this._errorBloc = errorBloc,
        this._loadingBloc = loadingBloc {
    _sAccountBlocModel = AccountBlocModel(
        token: null, loginState: LoginState.loggedOut, bloc: this);
    init();
  }

  init() async {
    _loadingBloc.startLoading();
    try {
      _sAccountBlocModel = AccountBlocModel(
          token: null, loginState: LoginState.loggedOut, bloc: this);
      // fetch the token from shared preferences
      _preferences = await SharedPreferences.getInstance();
      final token = _preferences.getString(AUTH_TOKEN_KEY);
      if (token == null)
        return;
      else
        _sAccountBlocModel = AccountBlocModel(
            token: token, loginState: LoginState.loggedIn, bloc: this);
    } catch (error) {
      _errorBloc.setError("$error");
    } finally {
      _loadingBloc.stopLoading();
    }
  }

  dispose() {
    _subject.close();
  }

  login(String email, String password) async {
    _loadingBloc.startLoading();
    try {
      final newToken = await _loginService.signInGetToken(email, password);
      _preferences.setString(AUTH_TOKEN_KEY, newToken);
      _sAccountBlocModel = AccountBlocModel(
          token: newToken, loginState: LoginState.loggedIn, bloc: this);
    } catch (e) {
      _errorBloc.setError("$e");
    } finally {
      _loadingBloc.stopLoading();
    }
  }

  createAccount(String email, String password) async {
    _loadingBloc.startLoading();
    try {
      final newToken =
          await _createService.createAccountAndGetToken(email, password);
      _preferences.setString(AUTH_TOKEN_KEY, newToken);
      _sAccountBlocModel = AccountBlocModel(
          token: newToken, loginState: LoginState.loggedIn, bloc: this);
    } catch (e) {
      _errorBloc.setError("$e");
    } finally {
      _loadingBloc.stopLoading();
    }
  }

  logoutAndDeleteData() async {
    _loadingBloc.startLoading();
    try {
      final signedOut =
          await _loginService.signOutAndDelete(_accountBlocModel.token);
      final clearedPreference = await _preferences.clear();
      if (!(signedOut && clearedPreference))
        _errorBloc.setError("Could not log out\nRestart app and try again");
      _sAccountBlocModel = AccountBlocModel(
          token: null, loginState: LoginState.loggedOut, bloc: this);
    } catch (e) {
      _errorBloc.setError('$e');
    } finally {
      _loadingBloc.stopLoading();
    }
  }
}
