import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlay = false;
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
        videoPlayerController.addListener(_onVideoPositionChanged);
      });
  }

  void _onVideoPositionChanged() {
    // Check if the current position of the video is equal to the duration of the video
    if (videoPlayerController.value.position >=
        videoPlayerController.value.duration) {
      setState(() {
        isEnd = true;
      });
    } else {
      setState(() {
        isEnd = false;
      });
    }
  }

  void controlVideoPlayPause() {
    if (isPlay) {
      videoPlayerController.pause();
    } else {
      videoPlayerController.play();
    }
    setState(() {
      isPlay = !isPlay;
    });
  }

  void playAgain() {
    if (isEnd) {
      videoPlayerController.seekTo(Duration.zero);
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: videoPlayerController.value.aspectRatio,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController),
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: controlVideoPlayPause,
                icon: Icon(
                  isPlay ? Icons.pause_circle : Icons.play_circle,
                )),
          ),
          IconButton(
            onPressed: playAgain,
            icon: Icon(isEnd ? Icons.refresh_sharp : null),
          )
        ],
      ),
    );
  }
}
