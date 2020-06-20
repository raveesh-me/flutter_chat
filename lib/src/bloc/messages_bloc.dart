import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/models/message.dart';
import 'package:simpleholmuskchat/src/service/api/messages_service.dart';

import 'account_bloc.dart';

class MessagesBlocModel {
  final List<Message> messages;
  final MessagesBloc bloc;

  MessagesBlocModel(this.messages, this.bloc);
}

class MessagesBloc {
  final MessagesService _messagesService;
  final ErrorBloc _errorBloc;
  final AccountBlocModel accountBlocModel;

  MessagesBlocModel _messagesBlocModel;
  set messages(List<Message> messages) {
    _messagesBlocModel = MessagesBlocModel(messages, this);
    _messageBlocSubject.add(_messagesBlocModel);
  }

  MessagesBloc(this._messagesService, this._errorBloc, this.accountBlocModel);

  BehaviorSubject<MessagesBlocModel> _messageBlocSubject = BehaviorSubject();

  getMessages(String friendId) async {
    try {
      if (accountBlocModel.token == null ||
          accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      messages =
          await _messagesService.getMessages(accountBlocModel.token, friendId);
      return;
    } catch (e) {
      _errorBloc.setError("Failed to fetch messages: $e");
    }
  }

  sendMessage(String friendId, Message message) async {
    try {
      if (accountBlocModel.token == null ||
          accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      messages = await _messagesService.sendMessage(
          accountBlocModel.token, friendId, message);
    } catch (e) {
      _errorBloc.setError("Failed to fetch messages: $e");
    }
  }

  dispose() {
    _messageBlocSubject.close();
  }
}
