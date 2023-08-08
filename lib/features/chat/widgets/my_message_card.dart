import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_text_image_gif.dart';
import '../../../colors.dart';

class MyMessageCard extends ConsumerWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String userName;
  final String repliedText;
  final MessageEnum repliedMessageType;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.userName,
    required this.repliedText,
    required this.repliedMessageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isReplying = repliedText.isNotEmpty;
    final size = MediaQuery.of(context).size;
    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: messageColor,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? EdgeInsets.only(
                          left: 7,
                          right: message.length < 50 ? 90 : 7,
                          top: 5,
                          bottom: message.length < 50 ? 10 : 20,
                        )
                      : const EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 5,
                          bottom: 5,
                        ),
                  child: Column(
                    children: [
                      if (isReplying) ...[
                        Text(
                          userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: backgroundColor.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(5)),
                          child: DisplayTextImageGIF(
                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                      DisplayTextImageGIF(message: message, type: type),
                    ],
                  ),
                ),
                FutureBuilder(
                    future:
                        ref.watch(chatControllerProvider).getCurrentUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(); // Show a loading indicator
                      }
                      return  Positioned(
                          top: -15,
                          right: -20,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data!.profilePic),
                            radius: 14,
                          ));
                    }),
                Positioned(
                  bottom: 4,
                  right: 5,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.done_all,
                        size: 20,
                        color: Colors.white60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
