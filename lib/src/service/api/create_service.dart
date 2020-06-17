import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

import '../../../op_environments.dart';

/// Unauthenticated, does not need a token
class CreateService {
  final String _path = '/create';

  Future<String> createAccountAndGetToken(String email, String password) async {
    var urlOptions = await UrlOptions.init(opEnvironment);
    final http.Response response = await http.post(
      "${urlOptions.baseUrl}$_path",
      body: {
        email: email,
        password: password,
      },
    );
    if (response.statusCode == 200)
      return json.decode(response.body)["token"];
    else
      return HttpErrorHandler.handleResponseError(response);
  }
}
