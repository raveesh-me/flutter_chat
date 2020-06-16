import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class ProfileBlocModel {
  final Profile profile;
  final ProfileBloc bloc;

  ProfileBlocModel(this.profile, this.bloc);
}

class ProfileBloc {
  ProfileService profileService;

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

  init() {
    mProfile = Profile('id', 'name', 'avatarUrl');
  }

  refreshProfile() {}

  changeProfile(Profile profile) {}
}
