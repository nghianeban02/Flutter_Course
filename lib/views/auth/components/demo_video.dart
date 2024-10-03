import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDemo extends StatefulWidget {
  const VideoDemo({super.key});

  @override
  State<VideoDemo> createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  String API_KEY = 'AIzaSyDwWkOGBwHy9kCnixkjiwjLtVVOgvmdDsM';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'gsPb3nDy41w',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: true,
      ),
    );
  }

//hiển thị video demo trên youtube
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                children: [
                  AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    insetPadding:
                        EdgeInsets.all(0), // You can adjust this padding
                    content: YoutubePlayer(
                      controller: _controller,
                      aspectRatio: constraints.maxWidth/710,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Bỏ qua'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed:() => _showDialog(),
          child: const Text('Video Demo'),
        ),
      ],
    );
  }
}
