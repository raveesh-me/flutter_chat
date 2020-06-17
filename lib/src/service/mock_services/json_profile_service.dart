import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

class JsonProfileService implements ProfileService {
  @override
  Future<Profile> getProfile() =>
      Future.value(Profile('id', 'name', 'avatarUrl'));

  @override
  Future<Profile> updateProfile(Profile newProfile) => Future.value(newProfile);
}
