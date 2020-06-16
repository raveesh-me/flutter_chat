import 'dart:convert';
import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

/// Unauthenticated, does not need a token
class CreateService {
  UrlOptions urlOptions;
  final String path = '/create';
  init() async {
    urlOptions = UrlOptions.fromJson(
      json.decode(await rootBundle.loadString('env/env.json'))["production"],
    );
  }

  Future<String> createAccountAndGetToken(String email, String password) async {
    if (urlOptions == null) await init();
    final http.Response response =
        await http.post(urlOptions.baseUrl + path, body: {
      email: email,
      password: password,
    });
    if (response.statusCode == 200)
      return json.decode(response.body)["token"];
    else
      return HttpErrorHandler.handleResponseError(response);
  }
}
