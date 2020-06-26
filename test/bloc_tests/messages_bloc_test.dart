import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simpleholmuskchat/src/bloc/account_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/messages_bloc.dart';
import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';

import 'friends_bloc_test.dart';

class MessagesServiceMock extends Mock implements MessagesService {}

main() {
  group('Messages Bloc...', () {
    MessagesService messagesService;
    AccountBlocModel accountBlocModel;
    ErrorBloc errorBloc;
    LoadingBloc loadingBloc;
    MessagesBloc messagesBloc;
    setUp(() {
      messagesService = MessagesServiceMock();
      accountBlocModel = AccountBlocModel(
          token: 'token',
          loginState: LoginState.loggedIn,
          bloc: MockAccountBloc());
      errorBloc = ErrorBloc();
      loadingBloc = LoadingBloc();
      messagesBloc = MessagesBloc(
        messagesService: messagesService,
        accountBlocModel: accountBlocModel,
        errorBloc: errorBloc,
        loadingBloc: loadingBloc,
      );

      test("CAN construct", () {
        expect(messagesBloc, isNotNull);
      });

      test("CAN get messages", () async {
        clearInteractions(messagesService);
        await messagesBloc.getMessages('friendId');
        verify(messagesService.getMessages('token', 'friendId')).called(1);
      });

      test("CAN send Messages", () async {
        clearInteractions(messagesService);
        await messagesBloc.sendMessage('friendId', Message('hello'));
        verify(messagesService.sendMessage('token', 'friendId', any)).called(1);
      });
    });
  });
}
