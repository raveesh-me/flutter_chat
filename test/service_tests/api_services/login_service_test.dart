import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';

main() {
  group("Login Service...", () {
    test("Can be initialized", () {
      LoginService loginService = LoginService();
      expect(loginService, isNotNull);
    });
  });
}
