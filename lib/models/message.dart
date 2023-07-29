import 'package:whatsapp_clone/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json["senderId"] ?? '',
      receiverId: json["receiverId"] ?? '',
      text: json["text"] ?? '',
      type: (json["type"] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(json["timeSent"]),
      messageId: json["messageId"] ?? '',
      isSeen: json["isSeen"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "text": text,
      "type": type.type,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "messageId": messageId,
      "isSeen": isSeen,
    };
  }

//
}
