import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget child;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: _isLoading
            ? LoadingAnimationWidget.waveDots(color: Colors.white, size: 35)
            : const Text(
                'Đăng nhập',
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
