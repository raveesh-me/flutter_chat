import 'package:simpleholmuskchat/src/helpers/logger.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';

import 'get_json_as_map.dart';

class JsonLoginService implements LoginService {
  @override
  Future<String> signInGetToken(String email, String password) async {
    debugLog(
        message: "Logging in.. \nEmail: $email \nPassword: $password",
        name: "JsonLoginService");
    return Map.from((await getLocalJsonAsObject("env/env.json")))["demo"]
        ["token"];
  }

  @override
  Future<bool> signOutAndDelete(String email) {
    debugLog(
        message: "SigningOut and Deleting all data, Email: $email",
        name: "JsonLoginService");
    return Future.value(true);
  }
}
