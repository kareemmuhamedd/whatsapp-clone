class ChatContact {
  final String name;
  final String profilePic;

  final String contactId;
  final DateTime timeSent;
  final String lastMessage;

  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  factory ChatContact.fromJson(Map<String, dynamic> json) {
    return ChatContact(
      name: json["name"] ?? '',
      profilePic: json["profilePic"] ?? '',
      contactId: json["contactId"] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(json["timeSent"]),
      lastMessage: json["lastMessage"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "profilePic": profilePic,
      "contactId": contactId,
      "timeSent": timeSent.millisecondsSinceEpoch,
      "lastMessage": lastMessage,
    };
  }

//
}
