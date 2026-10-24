import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade100,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Unlock Rewards with Points',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Classy',
                ),
              ),
              Lottie.network('https://lottie.host/30707e75-7f2b-45e7-9f8f-8fdb5e45ab63/4xPypWiBNR.json'),


              Text(

                'Explore endless possibilities—earn points, climb leaderboards, \nand unlock exclusive perks effortlessly!',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: 'Classy',
                ),
              )
            ],
          )
    ),
    );
  }
}