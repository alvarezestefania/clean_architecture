
import 'package:clean_architecture/core/errors/custom_exception.dart';
import 'package:clean_architecture/features/domain/entities/message_entity.dart';
import 'package:clean_architecture/features/domain/gateways/messages_gateway.dart';

class RegisterMessageUsecase {
  final MessagesGateway _messageGateway;
  RegisterMessageUsecase(this._messageGateway);

  Future<void> call(MessageEntity messageData) async {
    try {
      await _messageGateway.registerMessage(messageData);
    } catch (e) {
      throw CustomException('$e');
    }
  }
}
