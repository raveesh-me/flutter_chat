import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../op_environments.dart';

part 'url_options.g.dart';

@JsonSerializable()
class UrlOptions {
  UrlOptions(this.host, this.scheme, this.port);
  final String host;
  final String scheme;
  final String port;
  String get baseUrl => '$scheme://$host:$port';
  factory UrlOptions._fromJson(Map<String, dynamic> json) =>
      _$UrlOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlOptionsToJson(this);
  static Future<UrlOptions> init(OpEnvironments environment) async {
    try {
      // convert the enum to a string
      final String key = environment.toString().split('.')[1];
      // load json as string from rootBundle
      final String jsonData = await rootBundle.loadString('env/env.json');
      // decode the json into a map
      final Map<String, dynamic> map = json.decode(jsonData);
      // put in the key for extracting the enum based current environment
      final Map<String, dynamic> data = map[key];
      // create url options from the value on that key
      final urlOptions = UrlOptions._fromJson(data);
      // if anything unexpected happens, it will be null so throw
      if (urlOptions == null) throw UnimplementedError();
      return urlOptions;
    } catch (e) {
      log("Error: $e", name: "URL OPTIONS");
    }
  }
}
