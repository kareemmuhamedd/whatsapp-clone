import 'package:cloud_firestore/cloud_firestore.dart';

class Status {
  final String uid;
  final String username;
  final String phoneNumber;
  final List<String> photoUrl;
  final dynamic createdAt;
  final String profilePic;
  final String statusId;
  final List<String> whoCanSee;

  Status({
    required this.uid,
    required this.username,
    required this.phoneNumber,
    required this.photoUrl,
    required this.createdAt,
    required this.profilePic,
    required this.statusId,
    required this.whoCanSee,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      uid: json["uid"] ?? '',
      username: json["username"] ?? '',
      phoneNumber: json["phoneNumber"] ?? '',
      photoUrl: List<String>.from(json["photoUrl"]),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      profilePic: json["profilePic"] ?? '',
      statusId: json["statusId"] ?? '',
      whoCanSee: List<String>.from(json["whoCanSee"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "username": username,
      "phoneNumber": phoneNumber,
      "photoUrl": photoUrl,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "profilePic": profilePic,
      "statusId": statusId,
      "whoCanSee": whoCanSee,
    };
  }
}
