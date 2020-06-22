import 'package:rxdart/rxdart.dart';

class ErrorBlocModel {
  final bool hasError;
  final String errorMessage;
  final Function remedy;
  final String remedyLabel;
  final ErrorBloc bloc;
  final String originName;

  const ErrorBlocModel(
    this.hasError,
    this.errorMessage,
    this.remedy,
    this.remedyLabel,
    this.originName,
    this.bloc,
  );
}

class ErrorBloc {
  ErrorBlocModel _errorBlocModel;
  set _sErrorBlocModel(ErrorBlocModel newEBM) {
    _errorBlocModel = newEBM;
    _errorBlocSubject.add(_errorBlocModel);
  }

  ErrorBloc() {
    _sErrorBlocModel = ErrorBlocModel(false, null, null, null, null, this);
  }

  BehaviorSubject<ErrorBlocModel> _errorBlocSubject = BehaviorSubject();
  Stream<ErrorBlocModel> get stream => _errorBlocSubject.stream;

  clear() {
    _sErrorBlocModel = ErrorBlocModel(false, null, null, null, null, this);
  }

  setError(String errorMessage, String name,
      [Function remedy, String remedyLabel]) {
    _sErrorBlocModel =
        ErrorBlocModel(true, errorMessage, remedy, remedyLabel, name, this);
  }

  dispose() {
    _errorBlocSubject.close();
  }
}
