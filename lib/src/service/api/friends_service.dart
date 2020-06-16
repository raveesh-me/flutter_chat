import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

const _path = "/friends";

/// authenticates service
abstract class FriendsService {
  static Future<List<Friend>> getFriends(String token, [int page = 0]) async {
    final urlOptions = await UrlOptions.init(opEnvironment);
    final http.Response response = await http.get(
      "${urlOptions.baseUrl}$_path/$page",
      headers: {"token": token},
    );
    if (response.statusCode == 200)
      return json.decode(response.body)["token"];
    else
      return HttpErrorHandler.handleResponseError(response);
  }
}
