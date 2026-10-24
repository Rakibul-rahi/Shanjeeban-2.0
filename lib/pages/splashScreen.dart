import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:login/pages/base.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{



  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: Color(0xFF553373),
      splash: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assetsSadik/base002.png',
                height: 700,
              ),

              SizedBox(height: 30,),


            ],
          ),
        ),
      ),
      nextScreen: BaseScreen(),
      splashIconSize: 700,
      duration: 4000,
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
