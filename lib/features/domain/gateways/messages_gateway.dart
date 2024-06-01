import 'package:clean_architecture/features/domain/entities/message_entity.dart';

abstract class MessagesGateway {
  Future<MessageEntity> sendMessageToAi(MessageEntity messageData,List<MessageEntity> messageList);
  Future<void> registerMessage(MessageEntity messageData);
  Future<Stream<List<MessageEntity>>> getChatMessages(String customerId);
}