import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleholmuskchat/op_environments.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/service/api/create_service.dart';
import 'package:simpleholmuskchat/src/service/api/login_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/json_create_service.dart';
import 'package:simpleholmuskchat/src/service/mock_services/json_login_service.dart';

class AccountManagementProvider extends StatefulWidget {
  final Widget child;

  const AccountManagementProvider({Key key, @required this.child})
      : super(key: key);
  @override
  _AccountManagementProviderState createState() =>
      _AccountManagementProviderState();
}

class _AccountManagementProviderState extends State<AccountManagementProvider> {
  AccountBloc accountBloc;

  LoginService getLoginService() {
    switch (opEnvironment) {
      case OpEnvironments.demo:
        return JsonLoginService();
        break;
      case OpEnvironments.test:
        return JsonLoginService();
        break;
      case OpEnvironments.production:
        return LoginService();
        break;
    }
    throw UnimplementedError();
  }

  CreateService getCreateService() {
    switch (opEnvironment) {
      case OpEnvironments.demo:
        return JsonCreateService();
        break;
      case OpEnvironments.test:
        return JsonCreateService();
        break;
      case OpEnvironments.production:
        return CreateService();
        break;
    }
    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    accountBloc = AccountBloc(
      getLoginService(),
      getCreateService(),
      Provider.of<ErrorBlocModel>(context, listen: false).bloc,
    );
  }

  @override
  void dispose() {
    super.dispose();
    accountBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AccountBlocModel>.value(
      value: accountBloc.stream,
      child: widget.child,
    );
  }
}
