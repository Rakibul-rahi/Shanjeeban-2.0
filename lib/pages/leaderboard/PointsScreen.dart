import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'Distribution.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({super.key});

  @override
  State<PointsScreen> createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4E3E1),
        appBar: AppBar(
          backgroundColor: Color(0xFFADDCD),
          centerTitle: true,
          title: Text(
            'Claim Your Rewards',
            style: TextStyle(
              fontFamily: 'Classy',
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineAwesomeIcons.angle_left),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context){
                      return Center(child: CircularProgressIndicator());
                    }
                );
                Future.delayed(Duration(seconds: 1), () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Distribution(), // Replace with your screen/widget
                  ),
                ).then((_) {
                  if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                });
                });
              },
              icon: Icon(
                  LineAwesomeIcons.question_circle,
                size: 30,
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
        
              children: [
                Container(
        
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color(0xFFADC4C1),
                  ),
                  child: ClipOval(
                    child: Image(
        
                      image: AssetImage(
                        'assetsSadik/Profile.jpg',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  'Abdul Jabbar',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Classy',
                    fontSize: 30,
                  ),
                ),
                Container(
                  width: 200,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 50,),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFFE80C0C), Color(0xFF810707),],

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.grey.shade800,
                      width: 5,
                    ),
                  ),
                  child: ClipOval(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '253', // Replace with your actual text
                          style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Classy',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Classy',
                    color: Colors.red.shade800,
                  ),
                ),
                SizedBox(height: 40,),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                    
                      children: [
                        SizedBox(height: 20,),
                        OfferCoupons(
                            onpress: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.global.foodpanda.android',
                                openStore: true,
                              );
                            },
                            image: 'assetsSadik/foodpanda.png',
                            textOne: 'Get 50% Cashback\n',
                            textTwo: 'using 600 Points\n',
                            textThree: 'Serving Happiness, One bite at a time'
                        ),
                    
                        SizedBox(height: 20,),
                        OfferCoupons(
                            onpress: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.pathao.user',
                                openStore: true,
                              );
                            },
                            image: 'assetsSadik/pathao.png',
                            textOne: 'Get 50% Cashback\n',
                            textTwo: 'using 800 Points\n',
                            textThree: 'Pathao: Effortless Travel Elegance.'
                        ),
                        SizedBox(height: 20,),
                        OfferCoupons(
                            image: 'assetsSadik/arogga.jpg',
                            textOne: 'Get 50% Cashback\n',
                            textTwo: 'using 600 Points\n',
                            textThree: 'Arogga: Healing at Doorstep',
                            onpress: () async {
                              await LaunchApp.openApp(
                                androidPackageName: 'com.arogga.app',
                                openStore: true,
                              );
                            },
                        ),
                        SizedBox(width: 20,),
                    
                        // Add more containers here if needed
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferCoupons extends StatelessWidget {
  const OfferCoupons({
    super.key, required this.image, required this.textOne, required this.textTwo, required this.textThree, required this.onpress, this.textSize = 14.0,
  });

  @override

  final String image;
  final String textOne;
  final String textTwo;
  final String textThree;
  final VoidCallback onpress;
  final double textSize;

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
                    style: TextStyle(
                      fontSize: textSize,
                    )
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
                LineAwesomeIcons.angle_right,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
