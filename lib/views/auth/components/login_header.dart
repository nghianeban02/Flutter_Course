import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LoginPageHeader extends StatefulWidget {
  const LoginPageHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPageHeader> createState() => _LoginPageHeaderState();
}

class _LoginPageHeaderState extends State<LoginPageHeader> {
  String API_KEY = 'AIzaSyDwWkOGBwHy9kCnixkjiwjLtVVOgvmdDsM';
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
    });
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
                      aspectRatio: constraints.maxWidth/650,
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
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset(AppImages.roundedLogo),
          ),
        ),
        Text(
          'Chào mừng bạn đến với',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Kara Shop',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        )
      ],
    );
  }
}
