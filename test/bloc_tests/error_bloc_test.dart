import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';

main() {
  group("Error Bloc...", () {
    ErrorBloc errorBloc;
    setUp(() {
      errorBloc = ErrorBloc();
    });
    tearDown(() {
      errorBloc.dispose();
    });
    test("CAN initialize", () {
      expect(errorBloc, isNotNull);
    });
    test("INIT not have error", () async {
      ErrorBlocModel errorBlocModel = await errorBloc.stream.first;
      expect(errorBlocModel.hasError, false);
    });
    test("CAN set error", () async {
      expect(
        errorBloc.stream,
        emitsInOrder([HasError(false), HasError(true)]),
      );
      errorBloc.setError("Error, something just happened", "ErrorBlocTest");
    });
    test("CAN take error message", () async {
      errorBloc.setError("Error, something just happened", "ErrorBlocTest");
      ErrorBlocModel errorBlocModel = await errorBloc.stream.first;
      expect(errorBlocModel.errorMessage, "Error, something just happened");
    });
    test("CAN set and clear error", () async {
      expect(
        errorBloc.stream,
        emitsInOrder([HasError(false), HasError(true), HasError(false)]),
      );
      errorBloc.setError("errorMessage", "ErrorBlocTest");
      errorBloc.clear();
    });
  });
}

class HasError extends CustomMatcher {
  HasError(matcher)
      : super("LoadingBlocModel has isLoading value of", "isLoading", matcher);
  @override
  Object featureValueOf(actual) {
    return (actual as ErrorBlocModel).hasError;
  }
}
