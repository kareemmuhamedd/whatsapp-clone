import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/widgets/error.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/select_contacts/controller/select_contact_controller.dart';

final selectedGroupContacts = StateProvider<List<Contact>>((ref) => []);

class SelectContactsGroup extends ConsumerStatefulWidget {
  const SelectContactsGroup({Key? key}) : super(key: key);

  @override
  ConsumerState<SelectContactsGroup> createState() => _SelectContactGroupState();
}

class _SelectContactGroupState extends ConsumerState<SelectContactsGroup> {
  List<int> selectedContactIndex = [];

  void selectContact(int index, Contact contact) {
    if (selectedContactIndex.contains(index)) {
      selectedContactIndex.removeAt(index);
    } else {
      selectedContactIndex.add(index);
    }
    setState(() {});
    ref
        .read(selectedGroupContacts.notifier)
        .update((state) => [...state, contact]);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getContactsProvider).when(
      data: (contactList) => Expanded(
        child: ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            final contact = contactList[index];
            return InkWell(
              onTap: () => selectContact(index, contact),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ListTile(
                  title: Text(
                    contact.displayName,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  leading: selectedContactIndex.contains(index)
                      ? IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.done),
                  )
                      : null,
                ),
              ),
            );
          },
        ),
      ),
      error: (err, trace) => ErrorScreen(error: err.toString()),
      loading: () => const Loader(),
    );
  }
}
