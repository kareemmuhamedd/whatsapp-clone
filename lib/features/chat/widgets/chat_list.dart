import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/models/message.dart';
import 'package:whatsapp_clone/features/chat/widgets/sender_message_card.dart';
import '../../../common/enums/message_enum.dart';
import 'my_message_card.dart';
import '../controller/chat_controller.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;

  const ChatList({Key? key, required this.receiverUserId}) : super(key: key);

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();

  void onMessageSwipe({
    required String message,
    required bool isMe,
    required MessageEnum messageEnum,
  }) {
    ref.read(messageReplyProvider.notifier).update(
          (state) => MessageReply(
            message: message,
            isMe: isMe,
            messageEnum: messageEnum,
          ),
        );
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream:
          ref.read(chatControllerProvider).chatStream(widget.receiverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        SchedulerBinding.instance.addPostFrameCallback((_) {
          messageController.jumpTo(messageController.position.minScrollExtent);
        });
        return ListView.builder(
          reverse: true,
          controller: messageController,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final messageData = snapshot.data![index];
            String timeSent = messageData.timeSent != null
                ? DateFormat.jm().format(messageData.timeSent!.toDate())
                : '';
            if (messageData.senderId != widget.receiverUserId) {
              return MyMessageCard(
                message: messageData.text,
                date: timeSent,
                type: messageData.type,
                repliedText: messageData.replyMessage,
                userName: messageData.replyTo,
                repliedMessageType: messageData.replyMessageType,
                onLeftSwipe: () {
                  onMessageSwipe(
                    message: messageData.text,
                    isMe: true,
                    messageEnum: messageData.type,
                  );
                },
              );
            }
            return SenderMessageCard(
              message: messageData.text,
              date: timeSent,
              type: messageData.type,
              repliedText: messageData.replyMessage,
              userName: messageData.replyTo,
              repliedMessageType: messageData.replyMessageType,
              onRightSwipe: () {
                onMessageSwipe(
                  message: messageData.text,
                  isMe: false,
                  messageEnum: messageData.type,
                );
              },
            );
          },
        );
      },
    );
  }
}
