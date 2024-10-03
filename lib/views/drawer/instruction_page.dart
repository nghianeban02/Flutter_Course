import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../core/components/app_back_button.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  String API_KEY = 'AIzaSyDwWkOGBwHy9kCnixkjiwjLtVVOgvmdDsM';
  late YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'gsPb3nDy41w',
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      hideControls: false,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Video demo app'),
      ),
      body: SizedBox(
        width: 1080,
        height: 1920,
        child: YoutubePlayer(
          controller: _controller,
          progressIndicatorColor: Colors.green,
          progressColors: const ProgressBarColors(
            playedColor: Colors.green,
            handleColor: Colors.green,
          ),
        ),
      ),
    );
  }
}
