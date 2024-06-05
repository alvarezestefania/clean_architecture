import 'package:clean_architecture/features/domain/message/entities/message_entity.dart';
import 'package:clean_architecture/features/presentation/bloc/chatCubit/chat_cubit.dart';
import 'package:clean_architecture/features/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputMessage extends StatefulWidget {
  final String customerId;
  const InputMessage({super.key, required this.customerId});

  @override
  State<InputMessage> createState() => _InputMessageState();
}

class _InputMessageState extends State<InputMessage> {
  final TextEditingController _messageController = TextEditingController();

  void sendMessage() async{
    if (_messageController.text.isNotEmpty) {
      MessageEntity messageEntity = MessageEntity(
      message: _messageController.text, 
      type: 1, 
      createdAt: DateTime.now(), 
      isAI: false, 
      senderId: widget.customerId
    );
    _messageController.clear();
    await context.read<ChatCubit>().sendMessage(messageEntity);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            controller: _messageController,
            hintText: 'Enter message',
            obscureText: false,
          )),
          IconButton(
                  onPressed: () => sendMessage(),
                  icon: const Icon(
                    Icons.send,
                    size: 40,
                  ))
         ],
      ),
    );
  }
}