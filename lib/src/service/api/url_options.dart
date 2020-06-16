import 'package:json_annotation/json_annotation.dart';

part 'url_options.g.dart';

@JsonSerializable()
class UrlOptions {
  UrlOptions(this.host, this.scheme, this.port);
  final String host;
  final String scheme;
  final String port;
  String get baseUrl => '$scheme://$host:$port';
  factory UrlOptions.fromJson(Map<String, dynamic> json) =>
      _$UrlOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$UrlOptionsToJson(this);
}
