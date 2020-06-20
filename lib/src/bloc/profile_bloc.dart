import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class ProfileBlocModel {
  final Profile profile;
  final ProfileBloc bloc;

  ProfileBlocModel(this.profile, this.bloc);
}

class ProfileBloc {
  final ProfileService profileService;
  final ErrorBloc errorBloc;
  final AccountBlocModel accountBlocModel;
  ProfileBloc(this.profileService, this.errorBloc, this.accountBlocModel);

  ProfileBlocModel _profileBlocModel;

  set mProfile(Profile profile) {
    _profileBlocModel = ProfileBlocModel(profile, this);
    _profileBlocSubject.add(_profileBlocModel);
  }

  final _profileBlocSubject = BehaviorSubject<ProfileBlocModel>();
  Stream<ProfileBlocModel> get stream => _profileBlocSubject.stream;

  dispose() {
    _profileBlocSubject.close();
  }

  getProfile() async {
    try {
      if (accountBlocModel.token == null ||
          accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged In");
      mProfile = await profileService.getProfile(accountBlocModel.token);
    } catch (e) {
      errorBloc.setError("$e");
    }
  }

  changeProfile(Profile profile) async {
    try {
      if (accountBlocModel.token == null ||
          accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged In");
      mProfile =
          await profileService.updateProfile(accountBlocModel.token, profile);
    } catch (e) {
      errorBloc.setError("$e");
    }
  }
}
