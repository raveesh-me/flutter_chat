import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

const String _path = "/messages";

/// authenticated service, needs tokens to work
class MessagesService {
  Future<List<Message>> getMessages(String token, String friendId) async {
    try {
      final urlOptions = await UrlOptions.init(opEnvironment);
      final http.Response response = await http.get(
          '${urlOptions.baseUrl}$_path/$friendId',
          headers: {"token": token});
      if (response.statusCode == 200) {
        final List<dynamic> _list = List.from(json.decode(response.body));
        final List<Message> messages =
            _list.map((e) => Message.fromJson(Map.from(e)));
        return messages;
      } else
        return HttpErrorHandler.handleResponseError(response);
    } catch (e) {
      log('$e', stackTrace: StackTrace.current, name: "Messages API Service");
    }
    throw UnimplementedError();
  }

  Future<List<Message>> sendMessage(
      String token, String friendId, Message message) async {
    try {
      final urlOptions = await UrlOptions.init(opEnvironment);
      final http.Response response = await http.post(
          '${urlOptions.baseUrl}$_path/$friendId',
          body: message.toJson(),
          headers: {"token": token});
      if (response.statusCode == 200) {
        final List<dynamic> _list = List.from(json.decode(response.body));
        final List<Message> messages =
            _list.map((e) => Message.fromJson(Map.from(e)));
        return messages;
      } else
        return HttpErrorHandler.handleResponseError(response);
    } catch (e) {
      log('$e', stackTrace: StackTrace.current, name: "Messages API Service");
    }
    throw UnimplementedError();
  }
}
