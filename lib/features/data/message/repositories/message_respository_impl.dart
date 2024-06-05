import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/data/message/datasource/message_datasource.dart';
import 'package:clean_architecture/features/domain/message/entities/message_entity.dart';
import 'package:clean_architecture/features/domain/message/gateways/messages_gateway.dart';

class MessageRespositoryImpl implements MessagesGateway{
  final MessageDatasourceService messageDatasourceService;

  MessageRespositoryImpl(this.messageDatasourceService);

  @override
  Future<MessageEntity> sendMessageToAi(MessageEntity messageData,List<MessageEntity> messageList) async{
    try {
      final response= await messageDatasourceService.sendMessageToAi(messageData,messageList);
      return response;
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
  
  @override
  Future<Stream<List<MessageEntity>>> getChatMessages(String customerId) async{
    try {
      return await messageDatasourceService.getChatMessages(customerId);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }
  
  @override
  Future<void> registerMessage(MessageEntity messageData) async {
    try {
      return await messageDatasourceService.registerMessage(messageData);
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

}