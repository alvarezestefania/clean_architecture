import 'package:clean_architecture/features/domain/entities/message_entity.dart';
import 'package:clean_architecture/features/domain/usecases/messages/getmessages_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/registermessage_usecase.dart';
import 'package:clean_architecture/features/domain/usecases/messages/sendMessage_usecase.dart';
import 'package:clean_architecture/features/presentation/bloc/chatCubit/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  final SendMessageToAiUsecase _sendMessageToAiUsecase;
  final GetChatMessagesUsecase _getChatMessagesUsecase;
  final RegisterMessageUsecase _registerMessageUsecase;

  ChatCubit(
  this._getChatMessagesUsecase, 
  this._registerMessageUsecase,
  this._sendMessageToAiUsecase)
      : super(ChatInitial()){
    _loadMessages("9ac01356-0b07-4695-b840-6f76f7042ec9");
  }

  Future<void> _loadMessages(String customerId) async {
    try {
      emit(ChatLoading());
      final messageStream = await _getChatMessagesUsecase(customerId);
      final messageList = await messageStream.first;
      emit(ChatLoaded(messageList));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> sendMessage(MessageEntity messageData) async {
     try {
      await _registerMessageUsecase(messageData);
      final messageStream = await _getChatMessagesUsecase(messageData.senderId);
      final messageList = await messageStream.first;
      await _sendMessageToAiUsecase(messageData,messageList); 
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
