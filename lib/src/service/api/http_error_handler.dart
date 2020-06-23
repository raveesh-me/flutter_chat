import 'package:http/http.dart';

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

abstract class AppHttpExcepion implements Exception {
  String get message;
  String toString() => 'Exception: $message';
}

class SessionExpiredException extends AppHttpExcepion {
  String message;
  SessionExpiredException(this.message);
}

class BadParameterException extends AppHttpExcepion {
  String message;
  BadParameterException(this.message);
}

class UnknownEndpointException extends AppHttpExcepion {
  String message;
  UnknownEndpointException(this.message);
}

class InternalServerErrorException extends AppHttpExcepion {
  String message;
  InternalServerErrorException(this.message);
}
