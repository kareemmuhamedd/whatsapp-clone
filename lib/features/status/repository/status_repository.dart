import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:whatsapp_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import '../../../models/status_model.dart';
import '../../../models/user_model.dart';

final statusRepositoryProvider = Provider(
  (ref) => StatusRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
    ref: ref,
  ),
);

class StatusRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;

  StatusRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void uploadStatus({
    required String username,
    required String profilePic,
    required String phoneNumber,
    required File statusImage,
    required BuildContext context,
  }) async {
    try {
      var statusId = const Uuid().v1();
      String uid = auth.currentUser!.uid;
      String imageUrl = await ref
          .read(commonFirebaseStorageRepositoryProvider)
          .storeFileToFirebase(
            '/status/$statusId$uid',
            statusImage,
          );
      List<Contact> contacts = [];

      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
      List<String> uidWhoCanSee = [];
      for (int i = 0; i < contacts.length; i++) {
        var userDataFromFirebase = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: contacts[i].phones[0].number.replaceAll(' ', ''),
            )
            .get();
        if (userDataFromFirebase.docs.isNotEmpty) {
          UserModel userData = UserModel.fromJson(
            /// ******* WHY I TYPE docs[0] ??? *******
            /// i put 0 here because i will make sure if the phone number
            /// is on the firebase or not
            /// so if it was exist i will get it, and it will be one number of course
            /// so i will get a list of query snapshot that have only one data so i put [0]
            userDataFromFirebase.docs[0].data(),
          );
          uidWhoCanSee.add(userData.uid);
        }
      }
      List<String> statusImageUrlsList = [];
      var statusSnapshot = await firestore
          .collection('status')
          .where(
            'uid',
            isEqualTo: auth.currentUser!.uid,
          )
          .get();
      if (statusSnapshot.docs.isNotEmpty) {
        // add more status if i have at lest one status
        Status status = Status.fromJson(statusSnapshot.docs[0].data());
        statusImageUrlsList = status.photoUrl;
        statusImageUrlsList.add(imageUrl);
        await firestore
            .collection('status')
            .doc(statusSnapshot.docs[0].id)
            .update(
          {
            'photoUrl': statusImageUrlsList,
          },
        );
        return;
      } else {
        /// this mean that i don't have any status yet and i will add the fires story
        statusImageUrlsList = [imageUrl];
        Status status = Status(
          uid: uid,
          username: username,
          phoneNumber: phoneNumber,
          photoUrl: statusImageUrlsList,
          createdAt: DateTime.now(),
          profilePic: profilePic,
          statusId: statusId,
          whoCanSee: uidWhoCanSee,
        );
        await firestore.collection('status').doc(statusId).set(status.toJson());
      }

    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
