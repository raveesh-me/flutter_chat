import 'dart:convert';

import 'package:flutter/services.dart';
import "package:http/http.dart" as http;
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

/// Unauthenticated, does not need a token
class CreateService {
  UrlOptions urlOptions;
  final String path = '/create';
  init() async {
    urlOptions = await UrlOptions.fromJson(
        json.decode(await rootBundle.loadString('env/env.json')));
  }

  Future<String> createAccountAndGetToken(String email, String password) async {
    if (urlOptions == null) await init();
    final http.Response response = await http.get(urlOptions.baseUrl + path);
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body)["token"];
        break;
      case 400:
      case 401:
      case 404:
      case 400:
    }
  }
}
