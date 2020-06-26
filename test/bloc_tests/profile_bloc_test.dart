import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/profile_bloc.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

import 'friends_bloc_test.dart';

class MockProfileService extends Mock implements ProfileService {}

main() {
  group('Profile Bloc...', () {
    ProfileBloc profileBloc;
    ProfileService profileService;
    AccountBlocModel accountBlocModel;
    ErrorBloc errorBloc;
    LoadingBloc loadingBloc;

    setUp(() {
      profileService = MockProfileService();
      accountBlocModel = AccountBlocModel(
        token: 'token',
        loginState: LoginState.loggedIn,
        bloc: MockAccountBloc(),
      );

      errorBloc = ErrorBloc();
      loadingBloc = LoadingBloc();
      profileBloc = ProfileBloc(
          profileService: profileService,
          accountBlocModel: accountBlocModel,
          errorBloc: errorBloc,
          loadingBloc: loadingBloc);
    });

    test("CAN construct", () {
      expect(profileBloc, isNotNull);
    });

    test("CAN get profile", () async {
      clearInteractions(profileService);
      await profileBloc.getProfile();
      verify(profileService.getProfile('token')).called(1);
    });

    test("CAN change profile", () async {
      clearInteractions(profileService);
      await profileBloc.changeProfile(Profile('id', 'name', 'avatarUrl'));
      verify(profileService.updateProfile('token', any)).called(1);
    });
  });
}
