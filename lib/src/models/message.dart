import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  Message(this.message, [this.image, this.senderId, this.timeSent, this.id]);
  String id, message, senderId;
  List<int> image;
  DateTime timeSent;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  @override
  String toString() => '''
Message: ${toJson()}
  ''';
}
