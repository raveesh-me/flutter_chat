import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simpleholmuskchat/src/models/friend.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

abstract class FriendsService {
  UrlOptions urlOptions;
  final String path = '/create';
  init() async {
    urlOptions = UrlOptions.fromJson(
      json.decode(await rootBundle.loadString('env/env.json'))["production"],
    );
  }

  Future<List<Friend>> getFriends([int page = 0]) async {}
}
