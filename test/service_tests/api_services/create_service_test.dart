import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';

main() {
  group("Create Service...", () {
    test("CAN be initialized", () {
      CreateService createService = CreateService();
      expect(createService, isNotNull);
    });
  });
}
