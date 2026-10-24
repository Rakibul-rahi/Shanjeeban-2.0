import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageTwo extends StatelessWidget {
  const IntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                'Join Our Thriving Community',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Classy',
                ),
              ),

              Lottie.network('https://lottie.host/3c35a437-7150-4940-828d-4b8dda8586f5/fajwm80gfX.json'),

              Text(

                'Dive into a space where your voice is heard, connections flourish, \nand a sense of belonging awaits',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: 'Classy',
                ),
              )
            ],
          ),
      ),
    );
  }
}