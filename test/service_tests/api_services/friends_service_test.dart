import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/service/api/friends_service.dart';

main() {
  group("Friends Service...", () {
    test("Can be initialized", () {
      FriendsService friendsService = FriendsService();
      expect(friendsService, isNotNull);
    });
  });
}
