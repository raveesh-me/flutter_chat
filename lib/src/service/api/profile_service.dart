import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/models/profile.dart';
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';
import 'package:simpleholmuskchat/src/service/api/url_options.dart';

const String _path = "/profile";

class ProfileService {
  static Future<Profile> getProfile(String token) async {
    try {
      UrlOptions urlOptions = await UrlOptions.init(opEnvironment);
      http.Response response = await http.get(
        '${urlOptions.baseUrl}$_path',
        headers: {
          "token": token,
        },
      );
      if (response.statusCode == 200) {
        return Profile.fromJson(json.decode(response.body));
      } else
        return HttpErrorHandler.handleResponseError(response);
    } catch (e) {
      log('$e', name: "Get Profile", stackTrace: StackTrace.current);
    }
    throw UnimplementedError();
  }

  static Future<Profile> updateProfile(String token, Profile newProfile) async {
    try {
      UrlOptions urlOptions = await UrlOptions.init(opEnvironment);
      http.Response response = await http.put(
        '${urlOptions.baseUrl}$_path',
        body: newProfile.toJson(),
        headers: {
          "token": token,
        },
      );
      if (response.statusCode == 200) {
        return Profile.fromJson(json.decode(response.body));
      } else
        return HttpErrorHandler.handleResponseError(response);
    } catch (e) {
      log('$e', name: "Update Profile", stackTrace: StackTrace.current);
    }
    throw UnimplementedError();
  }
}
