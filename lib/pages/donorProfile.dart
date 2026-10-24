import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class donorProfile extends StatefulWidget {
  const donorProfile({super.key});

  @override
  State<donorProfile> createState() => _donorProfileState();
}

class _donorProfileState extends State<donorProfile> {
  @override


  void initState() {
    super.initState();
  }

  String? name;
  String? bloodGroup;
  int? age;
  String? donorUid;
  String? docId;
  int? phoneNumber;
  String? lastDonation;
  String? thana;
  String? district;



  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot3 = await FirebaseFirestore.instance.collection("newUserCredentials").doc(donorUid).get();
      if (userSnapshot3.exists) {
        String userName = userSnapshot3['name'];
        String blood = userSnapshot3['bloodGroup'];
        int number = userSnapshot3['number'];
        int boyosh = userSnapshot3['age'];
        String sheshDonation = userSnapshot3['lastDonation'];
        String thanaUse = userSnapshot3['thana'];
        String districtUse = userSnapshot3['district'];

        setState(() {
          name = userName;
          bloodGroup = blood;
          phoneNumber = number;
          age = boyosh;
          lastDonation = sheshDonation;
          thana = thanaUse;
          district = districtUse;

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

    final Map<String, dynamic> formData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    docId = formData['docId'];
    donorUid = formData['donorUid'];
    bloodGroup = formData['bloodGroup'];

    getUserData();

    String strAge = age.toString();
    String strNumber = phoneNumber.toString();

    return Scaffold(
      backgroundColor: Color(0xFFD4E3E1),
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFFADC4C1),
        title: Text("Donor's Profile"),
      ),
      body: SafeArea(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: EdgeInsets.only(
                  left: 20, top: 20, right: 20, bottom: 20,
                ),
                height: 530, width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFFADD1CD),
                  borderRadius: BorderRadius.circular(10),
                ),
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
                      name ?? 'loading....',
                      style: TextStyle(
                        color: Color(0xFF900000),
                        fontFamily: 'Classy',
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade800, // Adjust the color as needed
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(0, 2), // Adjust the shadow offset as needed
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child:IconButton(
                                onPressed: () async {
                                  final Uri url = Uri(
                                    scheme: 'tel',
                                    path: strNumber,
                                  );
                                  if (await canLaunchUrl(url)) {
                                    print("Launched");
                                    await launchUrl(url);
                                  } else {
                                    print('Cannot Launch');
                                  }
                                },
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.green.shade500,
                                ),
                              ),

                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade800, // Adjust the color as needed
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // Adjust the shadow offset as needed
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.message,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      width: 200,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Age: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          strAge ?? 'loading...',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Last Donation: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          lastDonation?? 'loading...',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),

                    Center(
                      child: Container(
                        //width: 400,
                        decoration: BoxDecoration(

                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(

                              children: [

                                Flexible(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${thana}, '?? 'laoding',
                                          softWrap: true,
                                          overflow: TextOverflow.clip, // Change to ellipsis if you want an ellipsis (...) when text overflows
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Classy',
                                            color: Colors.red[900],
                                          ),
                                        ),
                                        Text(
                                          district?? 'laoding',
                                          softWrap: true,
                                          overflow: TextOverflow.clip, // Change to ellipsis if you want an ellipsis (...) when text overflows
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Classy',
                                            color: Colors.red[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 10,),
                    Container(
                      //width: 400,
                      decoration: BoxDecoration(

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(height: 20,),
                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF900000)),
                                elevation: WidgetStateProperty.all<double>(10.0),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                              onPressed: (){

                              },
                              child: Text(
                                'REQUEST DONATOR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Classy',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
