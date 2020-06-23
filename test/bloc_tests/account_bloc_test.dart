import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';

class MockLoginService extends Mock implements LoginService {}

class MockCreateService extends Mock implements CreateService {}

main() {
  group("Account Bloc: ", () {
    MockLoginService loginService = MockLoginService();
    MockCreateService createService = MockCreateService();
    ErrorBloc errorBloc;
    LoadingBloc loadingBloc;
    AccountBloc accountBloc;

    setUp(() {
      errorBloc = ErrorBloc();
      loadingBloc = LoadingBloc();
      accountBloc = AccountBloc(
        loginService: loginService,
        createService: createService,
        errorBloc: errorBloc,
        loadingBloc: loadingBloc,
      );
      SharedPreferences.setMockInitialValues({AUTH_TOKEN_KEY: "SOME_TOKEN"});
    });
    tearDown(() {
      accountBloc.dispose();
      errorBloc.dispose();
      loadingBloc.dispose();
    });

    test("CAN construct", () {
      expect(accountBloc, isNotNull);
    });

    test('''
    CAN initialize 
    WHEN the service does not have error 
    WHEN no shared preferences
    ''', () async {
      SharedPreferences.setMockInitialValues({});
      await accountBloc.init();
      AccountBlocModel accountBlocModel = await accountBloc.stream.first;
      expect(accountBlocModel, HasLoginState(LoginState.loggedOut));
      expect(accountBlocModel, HasToken(null));
    });

    test('''
    CAN initialize
    WHEN the service does not have error
    WHEN shared preferences present
    ''', () async {
      await accountBloc.init();
      AccountBlocModel accountBlocModel = await accountBloc.stream.first;
      expect(accountBlocModel, HasLoginState(LoginState.loggedIn));
      expect(accountBlocModel, HasToken("SOME_TOKEN"));
    });

    test('''
    CAN set error
    WHILE calling create account and get token
    WHEN create service gives error
    WHEN SharedPreferences works ''', () async {
      when(createService.createAccountAndGetToken(any, any))
          .thenThrow(Exception("404 Resource not found"));
      await accountBloc.createAccount("email@email.com", 'password');
      final errorBlocModel = await errorBloc.stream.first;
      expect(errorBlocModel.errorMessage, "Exception: 404 Resource not found");
    });

    test('''
    CAN login and get token
    WHEN ''', () async {});

    test('''
    CAN logout and delete data
    WHEN service does not have error
    WHEN SharedPreferences works''', () async {
      AccountBlocModel accountBlocModel;
      await accountBloc.init();
      accountBlocModel = await accountBloc.stream.first;
      expect(accountBlocModel, HasLoginState(LoginState.loggedIn));
      expect(accountBlocModel, HasToken("SOME_TOKEN"));

      await accountBloc.logoutAndDeleteData();
      accountBlocModel = await accountBloc.stream.first;
      expect(accountBlocModel, HasLoginState(LoginState.loggedIn));

      final preferences = await SharedPreferences.getInstance();
      expect(preferences.getString(AUTH_TOKEN_KEY), null);

      verify(loginService.signOutAndDelete(any));
    });

    test('''
    CAN set error
    WHILE calling logout and delete data
    WHEN login service gives error
    WHEN SharedPreferences works ''', () async {
      when(createService.createAccountAndGetToken(any, any))
          .thenThrow(Exception("404 Resource not found"));
      await accountBloc.createAccount("email@email.com", 'password');
      final errorBlocModel = await errorBloc.stream.first;
      expect(errorBlocModel.errorMessage, "Exception: 404 Resource not found");
    });
  });
}

class HasLoginState extends CustomMatcher {
  HasLoginState(matcher)
      : super("AccountBlocModel has loginState", "loginState", matcher);
  @override
  Object featureValueOf(actual) => (actual as AccountBlocModel).loginState;
}

class HasToken extends CustomMatcher {
  HasToken(matcher)
      : super("AccountBlocModel has loginState", "loginState", matcher);
  @override
  Object featureValueOf(actual) => (actual as AccountBlocModel).token;
}
