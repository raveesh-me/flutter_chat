import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/get_json_as_map.dart';

class JsonCreateService implements CreateService {
  @override
  Future<String> createAccountAndGetToken(
          String email, String password) async =>
      Map.from((await getLocalJsonAsObject("env/env.json")))["demo"]["token"];
}
