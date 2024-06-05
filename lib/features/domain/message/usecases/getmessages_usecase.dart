
import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/message/entities/message_entity.dart';
import 'package:clean_architecture/features/domain/message/gateways/messages_gateway.dart';

class GetChatMessagesUsecase {
  final MessagesGateway _messageGateway;
  GetChatMessagesUsecase(this._messageGateway);

  Future<Stream<List<MessageEntity>>> call(String customerId) async {
    try {
      return await _messageGateway.getChatMessages(customerId);
    } catch (e) {
      throw CustomException('$e');
    }
  }
}