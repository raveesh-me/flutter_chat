import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class JsonProfileService implements ProfileService {
  @override
  Future<Profile> getProfile(String token) =>
      Future.value(Profile('id', 'name', 'avatarUrl'));

  @override
  Future<Profile> updateProfile(String token, Profile newProfile) =>
      Future.value(newProfile);
}
