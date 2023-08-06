import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/colors.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  void cancelReply(WidgetRef ref) {
    ref.read(messageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(messageReplyProvider);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: messageColor.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          ),
        ),
        width: 350,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    messageReply!.isMe ? 'Me' : 'Opposite',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => cancelReply(ref),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(15),
              ),
              child: messageReply.messageEnum == MessageEnum.image
                  ? SizedBox(
                      width: 80,
                      height: 100,
                      child: DisplayTextImageGIF(
                        message: messageReply.message,
                        type: messageReply.messageEnum,
                      ),
                    )
                  : DisplayTextImageGIF(
                      message: messageReply.message,
                      type: messageReply.messageEnum,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
