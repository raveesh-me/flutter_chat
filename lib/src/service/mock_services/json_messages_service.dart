import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';

class JsonMessagesService implements MessagesService {
  @override
  Future<List<Message>> getMessages(String token, String friendId) =>
      Future.value(
        List.generate(
          20,
          (index) => Message(
            'id',
            'message',
            'imageUrl',
            'senderId',
            DateTime.now(),
          ),
        ),
      );

  @override
  Future<List<Message>> sendMessage(
          String token, String friendId, Message message) =>
      Future.value(
        List.generate(
          21,
          (index) => Message(
            'id',
            'message',
            'imageUrl',
            'senderId',
            DateTime.now(),
          ),
        ),
      );
}
