import 'package:simpleholmuskchat/src/service/api/login_service.dart';

import 'get_json_as_map.dart';

class JsonLoginService implements LoginService {
  @override
  Future<String> signInGetToken(String email, String password) async =>
      Map.from((await getLocalJsonAsObject("env/env.json")))["demo"]["token"];

  @override
  Future<bool> signOutAndDelete(String email) => Future.value(true);
}
