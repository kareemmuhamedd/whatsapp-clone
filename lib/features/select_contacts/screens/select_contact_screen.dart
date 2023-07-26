import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';

class SelectContactScreen extends ConsumerWidget {
  static const routeName = '/select-contact';

  const SelectContactScreen({Key? key}) : super(key: key);

  void selectContact(
      Contact selectedContact, BuildContext context, WidgetRef ref) {
    ref.read(selectContactControllerProvider).selectedContact(
          selectedContact,
          context,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          )
        ],
        title: const Text('Select Contact'),
      ),
      body: ref.watch(getContactsProvider).when(
          data: (contactList) => ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (
                context,
                index,
              ) {
                final contact = contactList[index];
                return InkWell(
                  onTap: () => selectContact(contact, context, ref),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              backgroundImage: MemoryImage(contact.photo!),
                              radius: 30,
                            ),
                    ),
                  ),
                );
              }),
          error: (error, trace) => ErrorScreen(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
