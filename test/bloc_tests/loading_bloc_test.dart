import 'package:flutter_test/flutter_test.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';

main() {
  group("Loading Bloc...", () {
    LoadingBloc loadingBloc;

    setUp(() {
      loadingBloc = LoadingBloc();
    });

    tearDown(() {
      loadingBloc.dispose();
    });

    test("can initiate", () async {
      final LoadingBlocModel loadingBlocModel = await loadingBloc.stream.first;
      expect(loadingBlocModel, isNotNull);
    });

    test("initiates with a false", () async {
      final loadingBlocModel = await loadingBloc.stream.first;
      expect(loadingBlocModel, HasLoadingState(false));
    });

    test("emits true when startLoading", () async {
      expect(
        loadingBloc.stream,
        emitsInOrder([
          HasLoadingState(false),
          HasLoadingState(true),
        ]),
      );
      loadingBloc.startLoading();
    });
    test("emits false when stopLoading", () async {
      expect(
        loadingBloc.stream,
        emitsInOrder([
          HasLoadingState(false),
          HasLoadingState(false),
        ]),
      );
      loadingBloc.stopLoading();
    });
  });
}

class HasLoadingState extends CustomMatcher {
  HasLoadingState(matcher)
      : super("LoadingBlocModel has isLoading value of", "isLoading", matcher);
  @override
  Object featureValueOf(actual) {
    return (actual as LoadingBlocModel).isLoading;
  }
}
