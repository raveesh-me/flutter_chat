import 'package:json_annotation/json_annotation.dart';
part 'friend.g.dart';

@JsonSerializable()
class Friend {
  Friend(this.id, this.name, this.avatarUrl, this.lastMessage);
  String id, name, avatarUrl, lastMessage;

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
