import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Distribution extends StatefulWidget {
  const Distribution({super.key});

  @override
  State<Distribution> createState() => _DistributionState();
}

class _DistributionState extends State<Distribution> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        title: Text(
            'Points Distribution',
          style: TextStyle(
            fontFamily: 'Classy',
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          height: 400,
          width: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.red.shade200,
          ),
          child: Center( // Wrap Column with Center widget
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BulletText(text: '100 Points for Sign Up'),
                BulletText(text: '400 Points in First Blood Donation'),
                BulletText(text: '250 Points for Every Blood Donation'),
                BulletText(text: '3 Yearly Donation  : 500 Points'),
                BulletText(text: 'Gift for Birthday : 100 points'),
              ],
            ),
          ),
        ),
      )
    );
   }
}

class BulletText extends StatelessWidget {
  final String text;

  BulletText({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      textBaseline: TextBaseline.alphabetic,
      children: [
        Container(
          child: Text(
            '\u25CB',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Classy',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }
}

class OfferCoupons extends StatelessWidget {
  const OfferCoupons({
    super.key, required this.image, required this.textOne, required this.textTwo, required this.textThree, required this.onpress,
  });

  @override

  final String image;
  final String textOne;
  final String textTwo;
  final String textThree;
  final VoidCallback onpress;

  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Color(0xFFADC4C1),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 75, width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    image,
                    height: 70,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10,),
            RichText(

              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Classy',
                  fontWeight: FontWeight.bold,
                ),

                children: [
                  TextSpan(
                    text: textOne,
                  ),

                  TextSpan(
                    text: textTwo,
                    style: TextStyle(
                      color: Colors.red.shade800,

                    ),
                  ),
                  TextSpan(
                    text: textThree,
                    style: TextStyle(
                      color: Colors.pink.shade800,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: onpress,
              icon: Icon(
                LineAwesomeIcons.arrow_circle_right,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
