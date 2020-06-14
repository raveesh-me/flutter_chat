import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message(this.id, this.message, this.imageUrl, this.senderId, this.timeSent);
  String id, message, imageUrl, senderId;
  DateTime timeSent;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() => '''
Message: ${toJson()}
  ''';
}
