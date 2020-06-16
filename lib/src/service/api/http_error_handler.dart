import 'package:http/http.dart';

class HttpErrorHandler {
  static handleResponseError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw Exception(
            "Bad Request Parameters || Frontend Devs Made A Boo Boo");
        break;
      case 401:
        throw Exception("Session has expired, log out to log in again");
        break;
      case 404:
        throw Exception("Endpoints not found. Are you lost?");
        break;
      case 500:
        throw Exception(
          "Internal server error. A backend glitch, try again in a few days",
        );
        break;
      default:
        throw UnimplementedError(
            "There is an error which is not documented in our system");
    }
  }
}
