import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/features/chat/widgets/video_player_item.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? Padding(
                padding: const EdgeInsets.only(left: 120, right: 60),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return GestureDetector(
                      onTap: () async {
                        if (isPlaying) {
                          await audioPlayer.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        } else {
                          await audioPlayer.play(UrlSource(message));
                          setState(() {
                            isPlaying = true;
                          });
                        }
                      },
                      child: Icon(isPlaying
                          ? Icons.stop_circle_rounded
                          : Icons.play_circle,size: 30,),
                    );
                  },
                ),
              )
            : type == MessageEnum.video
                ? VideoPlayerItem(
                    videoUrl: message,
                  )
                : type == MessageEnum.gif
                    ? CachedNetworkImage(
                        imageUrl: message,
                        placeholder: (context, url) => const Loader(),
                      )
                    : CachedNetworkImage(
                        imageUrl: message,
                        placeholder: (context, url) => const Loader(),
                      );
  }
}
