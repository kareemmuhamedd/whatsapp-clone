import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/features/chat/widgets/display_text_image_gif.dart';
import '../../../colors.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: messageColor,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Stack(
          children: [
            Padding(
              padding: type == MessageEnum.text
                  ? const EdgeInsets.only(
                      left: 7,
                      right: 70,
                      top: 5,
                      bottom: 10,
                    )
                  : const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 5,
                      bottom: 5,
                    ),
              child: DisplayTextImageGIF(message: message, type: type),
            ),
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
    );
  }
}
