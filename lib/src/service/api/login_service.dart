import 'dart:convert';

import 'package:simpleholmuskchat/src/service/api/url_options.dart';
import 'package:http/http.dart' as http;
import '../../../op_environments.dart';
import 'http_error_handler.dart';

const String _path = '/login';

/// Unauthenticated, does not need a token, but returns one.
class LoginService {
  Future<String> signInGetToken(String email, String password) async {
    var urlOptions = await UrlOptions.init(opEnvironment);
    final http.Response response =
        await http.post(urlOptions.baseUrl + _path, body: {
      email: email,
      password: password,
    });
    if (response.statusCode == 200)
      return json.decode(response.body)["token"];
    else
      return HttpErrorHandler.handleResponseError(response);
  }

  Future<bool> signOutAndDelete(String token) async {
    var urlOptions = await UrlOptions.init(opEnvironment);
    final http.Response response = await http.delete(
      "${urlOptions.baseUrl}$_path",
      headers: {'token': token},
    );
    return response.statusCode == 200;
  }
}
