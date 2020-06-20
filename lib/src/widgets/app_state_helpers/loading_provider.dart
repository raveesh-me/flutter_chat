import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';

class LoadingProvider extends StatefulWidget {
  final Widget child;
  const LoadingProvider({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _LoadingProviderState createState() => _LoadingProviderState();
}

class _LoadingProviderState extends State<LoadingProvider> {
  LoadingBloc loadingBloc;
  @override
  void initState() {
    super.initState();
    loadingBloc = LoadingBloc();
  }

  @override
  void dispose() {
    super.dispose();
    loadingBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: loadingBloc.stream,
      child: widget.child,
    );
  }
}
