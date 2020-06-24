import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:matcher/matcher.dart';
import 'package:simpleholmuskchat/src/helpers/app_http_exceptions.dart';
import 'package:simpleholmuskchat/src/service/api/http_error_handler.dart';

main() {
  group("HTTP Error Handler: ", () {
    test("does not need initialization", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("Hello", 200)),
        throwsUnimplementedError,
      );
    });

    test("throws unimplemented error for unknown response code(eg: 200)", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("Hello", 200)),
        throwsUnimplementedError,
      );
    });

    test("throws BadParametersException when response code 400", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("", 400)),
        throwsA(TypeMatcher<BadParameterException>()),
      );
    });

    test("throws SessionExpiredException when response code 401", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("", 401)),
        throwsA(TypeMatcher<SessionExpiredException>()),
      );
    });

    test("throws UknownEndpointException when response code 404", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("", 404)),
        throwsA(TypeMatcher<UnknownEndpointException>()),
      );
    });

    test("throws InternalServerErrorException when response code 500", () {
      expect(
        () => HttpErrorHandler.handleResponseError(Response("", 500)),
        throwsA(TypeMatcher<InternalServerErrorException>()),
      );
    });
  });
}
