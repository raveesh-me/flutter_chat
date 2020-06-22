import 'dart:typed_data';

import 'package:simpleholmuskchat/src/helpers/logger.dart';
import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';

class JsonMessagesService implements MessagesService {
  final _name = "JsonMessageService";
  @override
  Future<List<Message>> getMessages(String token, String friendId) {
    debugLog(message: "Getting Messages: \nFriendId: $friendId", name: _name);
    return Future.value(
      List.generate(
        20,
        (index) => Message(
          'message',
          Uint8List(34),
          'senderId',
          DateTime.now(),
          'id',
        ),
      ),
    );
  }

  @override
  Future<List<Message>> sendMessage(
      String token, String friendId, Message message) {
    debugLog(message: "Sending message: $message \nto: $friendId", name: _name);
    return Future.value(
      List.generate(
        21,
        (index) => Message(
          'message',
          Uint8List(500),
          'senderId',
          DateTime.now(),
          'id',
        ),
      ),
    );
  }
}
