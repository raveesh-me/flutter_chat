import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

/// authenticates service
abstract class FriendsService {
  final _path = "/friends";
  final String _token;

  FriendsService(this._token);

  Future<List<Friend>> getFriends([int page = 0]) async {
    try {
      final urlOptions = await UrlOptions.init(opEnvironment);
      final http.Response response = await http.get(
        "${urlOptions.baseUrl}$_path/$page",
        headers: {"token": _token},
      );
      if (response.statusCode == 200) {
        final List<dynamic> _list = List.from(json.decode(response.body));
        final List<Friend> friendsList =
            _list.map((e) => Friend.fromJson(Map.from(e)));
        return friendsList;
      } else
        return HttpErrorHandler.handleResponseError(response);
    } catch (e) {
      log('$e', name: "Friends API Service", stackTrace: StackTrace.current);
    }
    throw UnimplementedError();
  }
}
