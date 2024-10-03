import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../../views/auth/intro_login_page.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //_navigateToHome();
  }

  // _navigateToHome() async {
  //   await Future.delayed(Duration(milliseconds: 2500), () {});
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: ((context) => OnboardingPage())));
  // }

// Màn hình intro khi khởi động
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E7D32),
      body: Center(
        child: Container(
          child: AnimatedSplashScreen(
            splash: Image.asset(
              'assets/images/app_logo_kara.png',
              width: 1800,
              height: 1800,
              ),
            nextScreen: const IntroLoginPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.green,
            duration: 3000,
          ),
        ),
      ),
    );
  }
}
