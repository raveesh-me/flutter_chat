import 'package:simpleholmuskchat/src/helpers/logger.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/get_json_as_map.dart';

class JsonCreateService implements CreateService {
  @override
  Future<String> createAccountAndGetToken(String email, String password) async {
    debugLog(message: "Creating new account...", name: 'JSON CREATE SERVICE');
    return Map.from((await getLocalJsonAsObject("env/env.json")))["demo"]
        ["token"];
  }
}
