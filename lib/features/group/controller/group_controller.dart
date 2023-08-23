import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/features/group/repository/group_repository.dart';

final groupControllerProvider = Provider((ref) {
  final groupRepository = ref.read(groupRepositoryProvider);
  return GroupController(
    groupRepository: groupRepository,
    providerRef: ref,
  );
});

class GroupController {
  final GroupRepository groupRepository;
  final ProviderRef providerRef;

  GroupController({
    required this.groupRepository,
    required this.providerRef,
  });

  void createGroup(
      BuildContext context,
      String name,
      File? image,
      List<Contact> selectedContact,
      ) {
    groupRepository.createGroup(
      context,
      name,
      image,
      selectedContact,
    );
  }
}
