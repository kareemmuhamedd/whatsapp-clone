import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final dynamic timeSent;
  final String messageId;
  final bool isSeen;
  final String replyMessage;
  final String replyTo;
  final MessageEnum replyMessageType;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
    required this.replyMessage,
    required this.replyTo,
    required this.replyMessageType,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"] ?? '',
      receiverId: json["receiverId"] ?? '',
      text: json["text"] ?? '',
      type: (json["type"] as String).toEnum(),
      timeSent: (json["timeSent"]),
      messageId: json["messageId"] ?? '',
      isSeen: json["isSeen"] ?? false,
      replyMessage: json["replyMessage"] ?? '',
      replyTo: json["replyTo"] ?? '',
      replyMessageType: (json["replyMessageType"] as String).toEnum(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "type": type.type,
      "timeSent": FieldValue.serverTimestamp(),
      "messageId": messageId,
      "isSeen": isSeen,
      "replyMessage": replyMessage,
      "replyTo": replyTo,
      "replyMessageType": replyMessageType.type,
    };
  }

//
}
