// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeScreen extends StatefulWidget {
  static const routeName = 'youtube_screen';
  final String youtube;
  const YoutubeScreen({
    Key? key,
    required this.youtube,
  }) : super(key: key);

  @override
  State<YoutubeScreen> createState() => _YoutubeScreenState();
}

class _YoutubeScreenState extends State<YoutubeScreen> {
  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    var url = widget.youtube;

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        loop: false,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller),
      builder: (context, player) => player,
    );
  }
}
