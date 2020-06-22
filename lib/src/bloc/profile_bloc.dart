import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class ProfileBlocModel {
  final Profile profile;
  final ProfileBloc bloc;

  ProfileBlocModel(this.profile, this.bloc);
}

class ProfileBloc {
  final _name = "PROFILE BLOC";
  ProfileBlocModel _profileBlocModel;
  final ProfileService _profileService;
  final AccountBlocModel _accountBlocModel;
  final ErrorBloc _errorBloc;
  final LoadingBloc _loadingBloc;

  set _sProfile(Profile profile) {
    _profileBlocModel = ProfileBlocModel(profile, this);
    _subject.add(_profileBlocModel);
  }

  final _subject = BehaviorSubject<ProfileBlocModel>();
  Stream<ProfileBlocModel> get stream => _subject.stream;

  ProfileBloc({
    @required ProfileService profileService,
    @required AccountBlocModel accountBlocModel,
    @required ErrorBloc errorBloc,
    @required LoadingBloc loadingBloc,
  })  : this._profileService = profileService,
        this._accountBlocModel = accountBlocModel,
        this._errorBloc = errorBloc,
        this._loadingBloc = loadingBloc {
    _sProfile = Profile('id', 'name', 'avatarUrl');
  }

  dispose() {
    _subject.close();
  }

  getProfile() async {
    _loadingBloc.startLoading();
    try {
      if (_accountBlocModel.token == null ||
          _accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged In");
      _sProfile = await _profileService.getProfile(_accountBlocModel.token);
    } catch (e) {
      _errorBloc.setError("$e", _name);
    } finally {
      _loadingBloc.stopLoading();
    }
  }

  changeProfile(Profile profile) async {
    _loadingBloc.startLoading();
    try {
      if (_accountBlocModel.token == null ||
          _accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged In");
      _sProfile =
          await _profileService.updateProfile(_accountBlocModel.token, profile);
      log("${_profileBlocModel.profile}");
    } catch (e) {
      _errorBloc.setError("$e", _name);
    } finally {
      _loadingBloc.stopLoading();
    }
  }
}
