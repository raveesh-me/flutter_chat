import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/service/api/profile_service.dart';

main() {
  group("Profile Service ...", () {
    test("Can be intialized", () {
      ProfileService profileService = ProfileService();
      expect(profileService, isNotNull);
    });
  });
}
