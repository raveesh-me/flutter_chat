import 'package:simpleholmuskchat/src/helpers/logger.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class JsonProfileService implements ProfileService {
  final _name = 'JsonProfileService';
  @override
  Future<Profile> getProfile(String token) {
    debugLog(message: "Fetching profile", name: _name);
    return Future.value(Profile('id', 'name', 'avatarUrl'));
  }

  @override
  Future<Profile> updateProfile(String token, Profile newProfile) async {
    debugLog(
        message: "Updating to new profile. \nProfile: $newProfile",
        name: _name);
    return Future.value(newProfile);
  }
}
