import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';

class ProfileBlocModel {
  final Profile profile;
  final ProfileBloc bloc;

  ProfileBlocModel(this.profile, this.bloc);
}

class ProfileBloc {
  ProfileBlocModel _profileBlocModel;
  set mProfile(Profile profile) {
    _profileBlocModel = ProfileBlocModel(profile, this);
    profileBlocSubject.add(_profileBlocModel);
  }

  final profileBlocSubject = BehaviorSubject<ProfileBlocModel>();

  dispose() {
    profileBlocSubject.close();
  }

  init() {
    mProfile = Profile('id', 'name', 'avatarUrl');
  }

  refreshProfile() {}

  changeProfile(Profile profile) {}
}
