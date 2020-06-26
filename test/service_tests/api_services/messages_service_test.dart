import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';

main() {
  group("Messages Service...", () {
    test("CAN be constructed", () {
      MessagesService messagesService = MessagesService();
      expect(messagesService, isNotNull);
    });
  });
}
