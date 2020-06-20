import 'package:rxdart/rxdart.dart';

class LoadingBlocModel {
  final bool isLoading;
  final LoadingBloc bloc;

  LoadingBlocModel(this.isLoading, this.bloc);
}

class LoadingBloc {
  LoadingBlocModel _loadingBlocModel;
  set _isLoading(bool loading) {
    _loadingBlocModel = LoadingBlocModel(loading, this);
    _subject.add(_loadingBlocModel);
  }

  BehaviorSubject<LoadingBlocModel> _subject = BehaviorSubject();
  Stream<LoadingBlocModel> get stream => _subject.stream;

  LoadingBloc() {
    _loadingBlocModel = LoadingBlocModel(false, this);
  }

  dispose(){
    _subject.close();
  }

  startLoading() {
    _isLoading = true;
  }

  stopLoading() {
    _isLoading = false;
  }
}
