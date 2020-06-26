import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/friends_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/service/api/friends_service.dart';

class MockFriendsService extends Mock implements FriendsService {}

class MockAccountBloc extends Mock implements AccountBloc {}

main() {
  group("Friends Bloc...", () {
    FriendsService friendsService = MockFriendsService();
    ErrorBloc errorBloc;
    LoadingBloc loadingBloc;
    AccountBlocModel accountBlocModel;
    FriendsBloc friendsBloc;

    setUp(() {
      errorBloc = ErrorBloc();
      loadingBloc = LoadingBloc();
      accountBlocModel = AccountBlocModel(
          token: "token",
          loginState: LoginState.loggedIn,
          bloc: MockAccountBloc());
      friendsBloc = FriendsBloc(
        friendsService: friendsService,
        errorBloc: errorBloc,
        accountBlocModel: accountBlocModel,
        loadingBloc: loadingBloc,
      );
    });

    test("CAN construct", () {
      expect(friendsBloc, isNotNull);
    });

    test('''
    CAN init
    ''', () async {
      when(friendsService.getFriends("token")).thenAnswer((realInvocation) =>
          Future.value(List.generate(20,
              (index) => Friend('id', 'name', 'avatarUrl', 'lastMessage'))));
      await friendsBloc.init();
      final result = await friendsBloc.stream.first;
      expect(result, isNotNull);
      expect(result.friends, isNotNull);
      expect(result.friends.length, 20);
    });

    test("INIT WHEN constructed", () async {
      clearInteractions(friendsService);
      friendsBloc = FriendsBloc(
          friendsService: friendsService,
          errorBloc: errorBloc,
          accountBlocModel: accountBlocModel,
          loadingBloc: loadingBloc);
      verify(friendsService.getFriends("token")).called(1);
    });
  });
}
