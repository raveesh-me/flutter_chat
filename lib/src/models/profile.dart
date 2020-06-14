import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile(this.id, this.name, this.avatarUrl);
  String id, name, avatarUrl;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  String toString() => """
Profile ${toJson()}
""";
}
