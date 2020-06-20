import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class LoadingBlocModel {
  final bool isLoading;
  final LoadingBloc bloc;

  LoadingBlocModel(this.isLoading, this.bloc);

  @override
  String toString() {}

  @override
  int get hashCode => hashValues(isLoading, 0);

  @override
  bool operator ==(Object other) {
    return other is LoadingBlocModel && other.isLoading == isLoading;
  }
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
    stopLoading();
  }

  dispose() {
    _subject.close();
  }

  startLoading() {
    _isLoading = true;
  }

  stopLoading() {
    _isLoading = false;
  }
}
