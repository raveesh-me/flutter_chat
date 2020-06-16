import 'package:simpleholmuskchat/src/models/friend.dart';

abstract class FriendsService {
  Future<List<Friend>> getFriends() async {}
}
