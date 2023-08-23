class Group {
  final String senderId;
  final String groupName;
  final String groupId;
  final String lastMessage;
  final String groupPic;
  final List<String> membersUid;

  Group({
    required this.senderId,
    required this.groupName,
    required this.groupId,
    required this.lastMessage,
    required this.groupPic,
    required this.membersUid,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      senderId: json["senderId"] ?? "",
      groupName: json["groupName"] ?? "",
      groupId: json["groupId"] ?? "",
      lastMessage: json["lastMessage"] ?? "",
      groupPic: json["groupPic"] ?? "",
      membersUid: List<String>.from(json["membersUid"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "senderId": senderId,
      "groupName": groupName,
      "groupId": groupId,
      "lastMessage": lastMessage,
      "groupPic": groupPic,
      "membersUid": membersUid,
    };
  }
}
