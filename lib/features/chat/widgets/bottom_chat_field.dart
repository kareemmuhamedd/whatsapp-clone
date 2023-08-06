import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:enough_giphy/src/models/gif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_clone/common/enums/message_enum.dart';
import 'package:whatsapp_clone/common/providers/message_reply_provider.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/features/chat/controller/chat_controller.dart';
import '../../../colors.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'message_reply_preview.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String receiverUserId;

  const BottomChatField({
    required this.receiverUserId,
    super.key,
  });

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  bool isShowEmojiContainer = false;
  FocusNode focusNode = FocusNode();
  Record? _audioRecord;
  AudioPlayer? _audioPlayer;
  bool isRecorderInit = false;
  bool isRecording = false;

  @override
  void initState() {
    _audioRecord = Record();
    _audioPlayer = AudioPlayer();
    startRecording();
    super.initState();
  }

  void startRecording() async {
    try {
      final status = await Permission.microphone.request();
      if (await _audioRecord!.hasPermission() &&
          status == PermissionStatus.granted) {
        isRecorderInit = true;
      }
    } catch (e) {
      print(e);
    }
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      // i don't need trim here !!!!!!
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.receiverUserId,
          );
      _messageController.clear();
      setState(() {
        isShowSendButton = false;
      });
    } else {
      var tempDir = await getTemporaryDirectory();
      var path = '${tempDir.path}/flutter_sound.acc';
      if (!isRecorderInit) {
        return;
      }
      if (isRecording) {
        await _audioRecord!.stop();
        sendFileMessage(File(path), MessageEnum.audio);
      } else {
        await _audioRecord!.start(path: path);
      }
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  void sendFileMessage(File file, MessageEnum messageEnum) {
    ref.read(chatControllerProvider).sendFileMessage(
          context,
          file,
          widget.receiverUserId,
          messageEnum,
        );
  }

  void selectImage() async {
    File? image = await pickImageFromGallery(context: context);
    if (image != null) {
      sendFileMessage(image, MessageEnum.image);
    }
  }

  void sendGIFMessage(GiphyGif gif) {
    ref.read(chatControllerProvider).sendGIFMessage(
          context,
          gif.url,
          widget.receiverUserId,
        );
  }

  void selectGIF() async {
    final GiphyGif? gif = await pickGIF(context);
    if (gif != null) {
      sendGIFMessage(gif);
    }
  }

  void selectVideo() async {
    File? video = await pickVideoFromGallery(context: context);
    if (video != null) {
      sendFileMessage(video, MessageEnum.video);
    }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    _audioPlayer!.dispose();
    _audioRecord!.dispose();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final MessageReply? messageReply = ref.watch(messageReplyProvider);
    final bool isShowMessageReply = messageReply != null;
    return Column(
      children: [
        isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: mobileChatBoxColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: toggleEmojiKeyboardContainer,
                            icon: Icon(
                              isShowEmojiContainer
                                  ? Icons.keyboard
                                  : Icons.emoji_emotions,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: selectGIF,
                            icon: const Icon(
                              Icons.gif,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  suffixIcon: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: selectImage,
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: selectVideo,
                            icon: const Icon(
                              Icons.attach_file,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  hintText: 'Type a message!',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2, left: 6),
              child: CircleAvatar(
                radius: 23,
                backgroundColor: const Color.fromRGBO(5, 96, 98, 1),
                child: GestureDetector(
                  onTap: sendTextMessage,
                  child: Icon(
                    isShowSendButton
                        ? Icons.send_rounded
                        : isRecording
                            ? Icons.close
                            : Icons.mic,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 210,
                child: EmojiPicker(
                  onEmojiSelected: ((Category? category, Emoji emoji) {
                    setState(() {
                      _messageController.text =
                          _messageController.text + emoji.emoji;
                    });
                    if (!isShowSendButton) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    }
                  }),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
