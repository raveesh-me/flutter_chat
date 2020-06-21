import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simpleholmuskchat/src/bloc/error_bloc.dart';
import 'package:simpleholmuskchat/src/bloc/loading_bloc.dart';
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
  final AccountBlocModel _accountBlocModel;
  final ErrorBloc _errorBloc;
  final LoadingBloc _loadingBloc;
  Timer _refreshMessagesTimer;

  MessagesBlocModel _messagesBlocModel;
  set _sMessages(List<Message> messages) {
    _messagesBlocModel = MessagesBlocModel(messages, this);
    _subject.add(_messagesBlocModel);
  }

  BehaviorSubject<MessagesBlocModel> _subject = BehaviorSubject();
  Stream<MessagesBlocModel> get stream => _subject.stream;

  MessagesBloc({
    @required MessagesService messagesService,
    @required AccountBlocModel accountBlocModel,
    @required ErrorBloc errorBloc,
    @required LoadingBloc loadingBloc,
  })  : this._messagesService = messagesService,
        this._accountBlocModel = accountBlocModel,
        this._errorBloc = errorBloc,
        this._loadingBloc = loadingBloc;

  clear() {
    _refreshMessagesTimer?.cancel();
  }

  dispose() {
    _subject.close();
    _refreshMessagesTimer?.cancel();
  }

  getMessages(String friendId) async {
    _loadingBloc.startLoading();
    try {
      if (_accountBlocModel.token == null ||
          _accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      _sMessages =
          await _messagesService.getMessages(_accountBlocModel.token, friendId);
      return;
    } catch (e) {
      _errorBloc.setError("Failed to fetch messages: $e");
    } finally {
      _loadingBloc.stopLoading();
      _refreshMessagesTimer = Timer(Duration(seconds: 5), () {
        getMessages(friendId);
      });
    }
  }

  sendMessage(String friendId, Message message) async {
    _loadingBloc.startLoading();
    try {
      if (_accountBlocModel.token == null ||
          _accountBlocModel.loginState == LoginState.loggedOut)
        throw Exception("Not logged in");
      _sMessages = await _messagesService.sendMessage(
          _accountBlocModel.token, friendId, message);
    } catch (e) {
      _errorBloc.setError("Failed to fetch messages: $e");
    } finally {
      _loadingBloc.stopLoading();
    }
  }
}
