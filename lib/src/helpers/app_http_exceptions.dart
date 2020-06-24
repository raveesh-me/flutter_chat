abstract class AppHttpException implements Exception {
  String get message;
  String toString() => 'Exception: $message';
}

class SessionExpiredException extends AppHttpException {
  String message;
  SessionExpiredException(this.message);
}

class BadParameterException extends AppHttpException {
  String message;
  BadParameterException(this.message);
}

class UnknownEndpointException extends AppHttpException {
  String message;
  UnknownEndpointException(this.message);
}

class InternalServerErrorException extends AppHttpException {
  String message;
  InternalServerErrorException(this.message);
}
