class MessageEntity {
  final String? id;
  final String message;
  final int type; // 1-text, 2-image, 3-audio
  final DateTime createdAt;
  final bool isAI;
  final String senderId;

  MessageEntity({
    this.id,
    required this.message,
    required this.type,
    required this.createdAt,
    required this.isAI,
    required this.senderId,
  });

   MessageEntity copyWith({String? message}) {
    return MessageEntity(
      id: id,
      message: message ?? this.message,
      type: type,
      createdAt: createdAt,
      isAI: isAI,
      senderId: senderId,
    );
  }
}
