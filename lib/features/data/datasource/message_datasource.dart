import 'dart:async';
import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/models/message_model.dart';
import 'package:clean_architecture/features/domain/entities/message_entity.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageDatasourceService {
  final SupabaseClient client;
  final Gemini geminiClient = Gemini.instance;

  MessageDatasourceService(this.client);

  Future<Stream<List<MessageEntity>>> getChatMessages(String customerId) async {
    try {
      final response = client
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('senderId', customerId)
          .order('createdAt')
          .map((maps) => maps.map((map) => MessageModel.fromMap(map)).toList());

      final messagesStream =
          response.map((messages) => messages.cast<MessageEntity>());
      return messagesStream;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  Future<void> registerMessage(MessageEntity messageData) async {
    try {
      await client.from('messages').insert({
        'message': messageData.message,
        'type': messageData.type,
        'createdAt': messageData.createdAt.toIso8601String(),
        'isAI': messageData.isAI,
        'senderId': messageData.senderId
      });
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  // Future<MessageEntity> sendMessageToAi(
  //     MessageEntity messageData, List<MessageEntity> messageList) async {
  //   String question = messageData.message;
  //   List<Uint8List>? images;
  //   try {
  //     MessageEntity responseController = MessageEntity(
  //       id: null,
  //       message: "",
  //       type: 1,
  //       createdAt: DateTime.now(),
  //       isAI: true,
  //       senderId: messageData.senderId,
  //     );

  //     geminiClient
  //         .streamGenerateContent(
  //       question,
  //       images: images,
  //     )
  //         .listen((event) {
  //       MessageEntity? lastMessage = messageList.firstOrNull;

  //       String response = event.content?.parts?.fold(
  //               "", (previous, current) => "$previous ${current.text}") ??
  //           "";

  //       if (lastMessage != null && lastMessage.isAI == true) {
  //         lastMessage = messageList.removeAt(0);
  //         MessageEntity updatedMessage =
  //             lastMessage.copyWith(message: lastMessage.message + response);
  //         responseController = updatedMessage;
  //         print("La repsuesta a tu solicitud f fue: $response");
  //       }

  //       MessageEntity newMessage = MessageEntity(
  //         id: null,
  //         message: response,
  //         type: 1,
  //         createdAt: DateTime.now(),
  //         isAI: true,
  //         senderId: messageData.senderId,
  //       );
  //       responseController = newMessage;

  //       responseController = newMessage;
  //       print("La repsuesta a tu solicitud fue: $response");
  //     });

  //     return responseController;
  //   } catch (e) {
  //     throw CustomException(e.toString());
  //   }
  // }

  Future<MessageEntity> sendMessageToAi(
      MessageEntity messageData, List<MessageEntity> messageList) async {
    try {
      try {
        String question = messageData.message;
        Completer<MessageEntity> completer = Completer<MessageEntity>();
        String aiResponse = '';

        await for (var event in geminiClient.streamGenerateContent(question)) {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          aiResponse += response;
        }

        MessageModel newMessage = MessageModel(
          id: null,
          message: aiResponse,
          type: 1,
          createdAt: DateTime.now(),
          isAI: true,
          senderId: messageData.senderId,
        );

        completer.complete(newMessage.toEntity());

        return completer.future;
      } catch (e) {
        throw Exception(e.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }
}
