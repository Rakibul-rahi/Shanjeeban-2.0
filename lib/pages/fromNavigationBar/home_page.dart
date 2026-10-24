import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/FacebookGroups.dart';
import 'package:login/pages/fromNavigationBar/NotificationPage.dart';
import 'package:login/pages/fromNavigationBar/historyPage.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String ?docID  = "gg";
  String ?name;
  String ?bloodGroup;
  String ?lastDonationDate;

  @override
  int _currentIndex = 0;
  final List<Widget> screens = [
    Home(),
    NotificatoinPage(),
    HostoryPage()
  ];

  Future<void> getDataDirectlyFromHome() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String? userID  = currentUser?.uid;
      docID = userID;

      if (currentUser != null) {
        DocumentSnapshot userSnapshot2 = await FirebaseFirestore.instance.collection("newUserCredentials").doc(userID).get();
        if (userSnapshot2.exists) {
          String userName = userSnapshot2['name'];
          String blood = userSnapshot2['bloodGroup'];
          String lastDonation = userSnapshot2['lastDonation'];

          setState(() {
            name = userName;
            bloodGroup = blood;
            lastDonationDate = lastDonation;
          });
        }
      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot3 = await FirebaseFirestore.instance.collection("newUserCredentials").doc(docID).get();
      if (userSnapshot3.exists) {
        String userName = userSnapshot3['name'];
        String blood = userSnapshot3['bloodGroup'];
        String lastDonation = userSnapshot3['lastDonation'];

        setState(() {
          name = userName;
          bloodGroup = blood;
          lastDonationDate = lastDonation;
        });

      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('docID')) {
      docID = args['docID'];

      getUserData();
    }
    else{
      getDataDirectlyFromHome();
    }

    // Example during user registration or login


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Red Container
            Container(
              height: 450, width: 500,
              decoration: BoxDecoration(

                color: Color(0xFF900000),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),


              ),
              padding: EdgeInsets.only(top: 50),

              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16,0, 16,0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Image.asset(
                            'assetsSadik/logo.png',
                            height: 40,
                          ),
                          Text(
                            name ?? 'loading....',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Classy',
                              fontWeight: FontWeight.bold,
                              fontSize: 15,

                            ),
                          ),
                          SizedBox(width: 135,),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context){
                                    return Center(child: CircularProgressIndicator());
                                  }
                              );
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushNamed(
                                    context, '/userProfile',
                                    arguments: {
                                      'docID' : docID,
                                    }
                                ).then((_) {
                                  if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                                });

                                  }
                              );
                              Future.delayed(Duration(seconds: 1), () {
                              Navigator.pushNamed(
                                  context, '/userProfile',
                                  arguments: {
                                    'docID' : docID,
                                  }
                              ).then((_) {
                                if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                              });

                              });
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey[100],
                              child: ClipOval(
                                child: Image.asset(
                                  'assetsSadik/Profile.jpg',
                                  height: 40,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BLOOD \nTYPE:',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Elegant',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              bloodGroup ?? 'loading....',
                              style: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Elegant',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 60,
                        child: const VerticalDivider(

                          color: Colors.yellow,
                          width: 10,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UNIT \nDONATED:',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Elegant',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              '05',
                              style: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Elegant',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),


                      Container(
                        height: 60,
                        child: const VerticalDivider(

                          color: Colors.yellow,
                          width: 10,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LAST \nDONATION:',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Elegant',
                            ),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              lastDonationDate ?? 'loading....',
                              style: TextStyle(
                                color: Colors.amber,
                                fontFamily: 'Elegant',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(

                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Every  Blood  Donor',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'Distorted',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'is  a  HERO',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            fontFamily: 'Distorted',
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30,),
                  Container(
                    height: 100, width: 700,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Image.asset(
                        'assetsSadik/Quota.png',





                      ),
                    ),
                  ),



                ],

              ),

            ),
            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                GestureDetector(
                  // onTap: () {
                  //   Navigator.pushNamed(
                  //       context, '/allRequests',
                  //       arguments: {
                  //         'docID' : docID,
                  //       }
                  //   );
                  // },

                 onTap: () async {


                    String bloodCheck = bloodGroup!;

                    showDialog(
                        context: context,
                        builder: (context){
                          return Center(child: CircularProgressIndicator());
                        }
                    );

                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    CollectionReference collectionRef = firestore.collection(bloodCheck);

                    QuerySnapshot querySnapshot = await collectionRef.get();

                    print(" ");print(" blood");
                    print(bloodGroup);
                    print(" ");print(" ");

                    if (querySnapshot.docs.isNotEmpty) {
                  Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamed(
                        context, '/everyRequest',
                        arguments: {
                          'docID': docID,
                        },
                      ).then((_) {
                      if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                          });
                       });
                    } else {
                   Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamed(
                        context, '/noReciever',
                        arguments: {
                          'docID': docID,
                        },
                      ).then((_) {
                        if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                      });
                   });
                    }
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,

                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),

                    padding: EdgeInsets.all(8), // Padding around the button content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assetsSadik/donateNow.png', // Replace with your image asset path
                          height: 30,

                        ),
                        SizedBox(height: 8), // Add some spacing between the image and text
                        Text(
                          'Donate Now',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your Help Matters',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
                GestureDetector(
                  onTap: () {
                  showDialog(
                   context: context,
                  builder: (context){
                   return Center(child: CircularProgressIndicator());
                     }
                      );
                  Future.delayed(Duration(seconds: 1), () {
                      Navigator.pushNamed(
                        context, '/requestForm',
                        arguments: {
                          'docID' : docID,

                        }
                    ).then((_) {
                if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                 });
                });
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assetsSadik/request.png',
                          height: 30,
                          //width: 60,
                        ),
                        SizedBox(height: 8), // Add some spacing between the image and text
                        Text(
                          'Request Blood',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Donors Waiting!',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                   showDialog(
                    context: context,
                     builder: (context){
                     return Center(child: CircularProgressIndicator());
                     }
                    );
                    Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushNamed(context, '/pointScreen'
                    ).then((_) {
                      if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                    });
                    });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(8), // Padding around the button content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assetsSadik/PointsIcon.png', // Replace with your image asset path
                          height: 30,
                        ),
                        SizedBox(height: 8), // Add some spacing between the image and text
                        Text(
                          '253 Points',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Claim Your Rewards!',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
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
                        builder: (context) => FacebookGroups(), // Replace with your screen/widget
                      ),
                    ).then((_) {
                      if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                    });
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(8), // Padding around the button content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assetsSadik/redFacebook.png', // Replace with your image asset path
                          height: 30,
                        ),
                        SizedBox(height: 8), // Add some spacing between the image and text
                        Text(
                          'Facebook',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Explore Communities!',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return Center(child: CircularProgressIndicator());
                        }
                    );
                    Future.delayed(Duration(seconds: 1), () {
                    Navigator.pushNamed(context, '/emergency'
                    ).then((_) {
                   if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                     });
                   });

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assetsSadik/ambulance.png',
                          height: 30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Emergency',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Your Nearby Service',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
