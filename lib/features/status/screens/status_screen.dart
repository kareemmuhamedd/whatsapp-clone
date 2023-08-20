import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:whatsapp_clone/common/widgets/loader.dart';
import 'package:whatsapp_clone/models/status_model.dart';

class StatusScreen extends StatefulWidget {
  static const routeName = '/status-screen';
  final Status status;

  const StatusScreen({Key? key, required this.status}) : super(key: key);

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  StoryController controller = StoryController();
  List<StoryItem> storyItemsList = [];

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItemsList.add(
        StoryItem.pageImage(
            url: widget.status.photoUrl[i], controller: controller),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItemsList.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: storyItemsList,
              controller: controller,
              onVerticalSwipeComplete: (direction) {
                if (direction == Direction.down) {
                  Navigator.pop(context);
                }
              },
              onComplete: () => Navigator.pop(context),
            ),
    );
  }
}
