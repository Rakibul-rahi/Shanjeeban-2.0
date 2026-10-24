import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login/pages/leaderboard/PointsScreen.dart';

class FacebookGroups extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red.shade200,
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
            'Facebook Groups',
            style: TextStyle(
              fontFamily: 'Classy',
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,


                children: [
                  Text(
                    'If We were not Enough...',
                    style: TextStyle(
                      fontFamily: 'Classy',
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade800,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20,),
                  OfferCoupons(
                      image: 'assetsSadik/pagePhotoFour.jpg',
                      textOne: 'Voluntary blood Donor Club (VBDC)\n',
                      textTwo: '340.6K Members\n',
                      textThree: 'Public Group\n',
                      onpress: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return Center(child: CircularProgressIndicator());
                            }
                        );
                        Future.delayed(Duration(seconds: 3), () {
                        launchUrl(Uri.parse('https://www.facebook.com/groups/BloodDonation24'), mode: LaunchMode.externalApplication).then((_) {
                   if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                        });
                     });
                      }
                  ),
                  SizedBox(height: 20,),
                  OfferCoupons(
                      image: 'assetsSadik/pagePhotoThree.jpg',
                      textOne: 'Blood Donation Bangladesh Welfare \nFoundation (BDBWF)\n',
                      textTwo: '18.3K members\n',
                      textThree: 'Public Group\n',

                      onpress: (){
                        showDialog(
                         context: context,
                          builder: (context){
                        return Center(child: CircularProgressIndicator());
                   }
                    );
                        Future.delayed(Duration(seconds: 3), () {
                        launchUrl(Uri.parse('https://www.facebook.com/groups/BloodDonation24'), mode: LaunchMode.externalApplication).then((_) {
                     if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                    });
                   });
                      }
                  ),
                  SizedBox(height: 20,),
                  OfferCoupons(
                      image: 'assetsSadik/pagePhotoTwo.jpg',
                      textOne: 'Dhaka Blood Donation Group\n',
                      textTwo: '15.9K Members\n',
                      textThree: 'Public Group',
                      onpress: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return Center(child: CircularProgressIndicator());
                            }
                        );
                        Future.delayed(Duration(seconds: 3), () {
                        launchUrl(Uri.parse('https://www.facebook.com/groups/dhakablooddonation'), mode: LaunchMode.externalApplication).then((_) {
                        if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                         });
                      });
                      }
                  ),
                  SizedBox(height: 20,),
                  OfferCoupons(
                      image: 'assetsSadik/pagePhotoOne.jpg',
                      textOne: 'B Positive Blood Donner Bangladesh\n',
                      textTwo: '5.5K Members\n',
                      textThree: 'Public Group',
                      onpress: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return Center(child: CircularProgressIndicator());
                            }
                        );
                        Future.delayed(Duration(seconds: 3), () {
                        launchUrl(Uri.parse('https://www.facebook.com/groups/730642890759835'), mode: LaunchMode.externalApplication).then((_) {
                          if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                        });
                        });
                      }
                  ),
                  SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.only(right: 80.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '***Kept current until January 20, 2024',
                          style: TextStyle(
                            fontFamily: 'Classy',
                          ),

                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}

