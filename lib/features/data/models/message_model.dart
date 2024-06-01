import 'package:clean_architecture/features/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity{
  MessageModel({
    required super.id,
    required super.message, 
    required super.type, 
    required super.createdAt, 
    required super.isAI, 
    required super.senderId
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'createdAt': createdAt,
      'isAI': isAI,
      'senderId': senderId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'],
      message: map['message'],
      type: map['type'],
      createdAt: DateTime.parse(map['createdAt']),
      isAI: map['isAI'],
      senderId: map['senderId'],
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json["id"],
      message: json["message"],
      type: json["type"],
      createdAt: json["createdAt"],
      isAI: json["isAI"],
      senderId: json["senderId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
      'createdAt': createdAt,
      'isAI': isAI,
      'senderId': senderId,
    };
  }

  MessageEntity toEntity(){
    return MessageEntity(
      id: id,
      message: message,
      type: type,
      createdAt: createdAt,
      isAI: isAI,
      senderId: senderId,
    );
  }

  @override
  MessageModel copyWith({
    String? id,
    String? message,
    int? type,
    DateTime? createdAt,
    bool? isAI,
    String? senderId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isAI: isAI ?? this.isAI,
      senderId: senderId ?? this.senderId,
    );
  }

}