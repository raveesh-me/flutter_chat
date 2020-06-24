import 'package:http/http.dart';
import 'package:simpleholmuskchat/src/helpers/app_http_exceptions.dart';

class HttpErrorHandler {
  static handleResponseError(Response response) {
    switch (response.statusCode) {
      case 400:
        throw BadParameterException(
            "Bad Request Parameters || Frontend Devs Made A Boo Boo");
        break;
      case 401:
        throw SessionExpiredException(
            "Session has expired, log out to log in again");
        break;
      case 404:
        throw UnknownEndpointException("Endpoints not found. Are you lost?");
        break;
      case 500:
        throw InternalServerErrorException(
          "Internal server error. A backend glitch, try again in a few days",
        );
        break;
      default:
        throw UnimplementedError(
            "There is an error which is not documented in our system");
    }
  }
}
