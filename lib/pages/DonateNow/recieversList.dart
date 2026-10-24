import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DonateNow extends StatefulWidget {
  const DonateNow({super.key});

  @override
  State<DonateNow> createState() => _DonateNowState();
}

class _DonateNowState extends State<DonateNow> {
  CollectionReference bloodRequests =
  FirebaseFirestore.instance.collection('A-');
  void getSpecificCollection() {
    bloodRequests = FirebaseFirestore.instance.collection(bloodGroup);
  }

  void onPersonClicked(String requestorUid) {
    print('Clicked on $requestorUid');
    print(bloodGroup);
    print(" ");
    print(" ");

    Navigator.pushNamed(
      context, '/requestedProfile',
      arguments: {
        'requestorUid' : requestorUid,
        'docId' : docID,
      },
    );
  }

  String docID = "gg";
  String bloodGroup = "nothing";

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot3 =
      await FirebaseFirestore.instance.collection("userCredentials").doc(docID).get();
      if (userSnapshot3.exists) {
        final newBloodGroup = userSnapshot3['bloodGroup'];
        if (newBloodGroup != bloodGroup) {
          setState(() {
            bloodGroup = newBloodGroup;
          });
        }
      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4E3E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFADD1CD),
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
          'Donate Now',
          style: TextStyle(
            fontFamily: 'Classy',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Column(

                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Text(
                      'DONATE NOW!',
                      style: TextStyle(
                        color: Color(0xFF900000),
                        fontSize: 25,
                        fontFamily: 'Classy',
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),


                ],
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class DonateNowList extends StatefulWidget {
  const DonateNowList({
    Key? key,
    required this.title, required this.onPress, required this.subtitle, required this.sub_subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String sub_subtitle;
  final VoidCallback onPress;

  @override
  State<DonateNowList> createState() => _DonateNowListState();
}

class _DonateNowListState extends State<DonateNowList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Color(0xFFADC4C1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF900000),
          width: 2.0,
        ),
      ),
      child: ListTile(

        onTap: widget.onPress,
        leading: Container(

          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFFADC4C1),
          ),
          child: ClipOval(
            child: Image(
              height: 50, width: 50,
              image: AssetImage(
                  'assetsSadik/Profile.jpg',
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            widget.title,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Classy',
              fontWeight: FontWeight.bold,
              fontSize: 15,
          ),
        ),
        Text(
          widget.subtitle,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.5),
            fontFamily: 'Classy',
            fontSize: 10,
          ),
        ),
        Text(
          widget.sub_subtitle,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.5),
            fontFamily: 'Classy',
            fontSize: 10,
          ),
        ),
        ]
      ),


        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withValues(alpha: 0.3),
          ),
          child: Icon(
            LineAwesomeIcons.angle_right,
            color: Colors.black,
          ),
        ),
      ),
    );
    SizedBox(height: 20,);
  }
}
