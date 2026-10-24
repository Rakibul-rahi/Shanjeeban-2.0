import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPageOne extends StatelessWidget {
  const IntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink.shade100,
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Shanjeeban',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontFamily: 'Classy',
                ),
              ),

              Lottie.network('https://lottie.host/c874fe5a-ff7b-484a-a270-ed8b10ee80c1/OreNG5UFkG.json'),

              Text(

                'Empowering lives through blood donation.\n Join our community of heroes, where every donation counts.\n Together, lets save lives and create a healthier, happier world!',
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  fontFamily: 'Classy',
                ),
              )
            ],
          )),
    );
  }
}
