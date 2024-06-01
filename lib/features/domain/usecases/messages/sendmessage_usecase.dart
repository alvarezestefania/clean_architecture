import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/message_entity.dart';
import 'package:clean_architecture/features/domain/gateways/messages_gateway.dart';

class SendMessageToAiUsecase{
  final MessagesGateway _messageGateway;
  SendMessageToAiUsecase(this._messageGateway);

  Future<void> call(MessageEntity messageData,List<MessageEntity> messageList) async {
    try {
      final aiResponse =
          await _messageGateway.sendMessageToAi(messageData, messageList);
      _messageGateway.registerMessage(aiResponse);  
      
      
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
