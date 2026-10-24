import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class RequestorProfile extends StatefulWidget {
  @override
  _RequestorProfileState createState() => _RequestorProfileState();
}

class _RequestorProfileState extends State<RequestorProfile> {

  String? name;
  String bloodGroup = "";
  int? age;
  String? requestorUid;
  String? docId;
  int? phoneNumber;
  String? lastDonation;
  String? thana;
  String? district;
  String hospital  = "dgf";
  String causeass = "dsg";
  int? quan;
  bool done = false;

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot3 = await FirebaseFirestore.instance.collection(bloodGroup).doc(requestorUid).get();
      if (userSnapshot3.exists) {
        String userName = userSnapshot3['name'];
        String blood = userSnapshot3['bloodGroup'];
        int number = userSnapshot3['phone'];
        int boyosh = userSnapshot3['age'];
        // String sheshDonation = userSnapshot3['lastDonation'];
        // String thanaUse = userSnapshot3['thana'];
        // String districtUse = userSnapshot3['district'];
        String causes = userSnapshot3['reason'];
        String hp = userSnapshot3['hospital'];
        int quant = userSnapshot3['quantity'];

        print('\n');
        print(userName);
        print(quant);


        setState(() {
          name = userName;
          bloodGroup = blood;
          phoneNumber = number;
          age = boyosh;
          // lastDonation = sheshDonation;
          // thana = thanaUse;
          // district = districtUse;
          causeass = causes;
          quan = quant;
          hospital = hp;
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
    requestorUid = formData['requestorUid'];
    bloodGroup = formData['bloodGroup'];

    if(done == false) {
      getUserData();
      done = true;
    }

    String strAge = age.toString();
    String strNumber = phoneNumber.toString();

    print("age : $age");
    print(causeass);
    print(hospital);
    print(quan);
    print(phoneNumber);

    return Scaffold(
      backgroundColor: Color(0xFFD4E3E1),
      appBar: AppBar(
        backgroundColor: Color(0xFFADD1CD),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        title: Text(
          'Donate Now',
        ),
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
                height: 590, width: 300,
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
                      name?? 'loading...',
                      style: TextStyle(
                        color: Color(0xFF900000),
                        fontFamily: 'Classy',
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20,),

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
                              child: IconButton(
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
                    SizedBox(height:10),
                    Container(
                      width: 200,
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),


                    SizedBox(height: 10,),
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
                          strAge?? 'loading...',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Blood Group: ',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          bloodGroup ?? 'loading...',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                          'Cause: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          causeass,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Quantity: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          quan.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Classy',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: Colors.red[900],
                              ),
                              SizedBox(width: 4), // Add spacing between the icon and text
                              Flexible(
                                child: Text(
                                  hospital,
                                  softWrap: true,
                                  overflow: TextOverflow.clip, // Change to ellipsis if you want an ellipsis (...) when text overflows
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Classy',
                                    color: Colors.red[900],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    CustomElevated(
                      requestorUid: requestorUid,
                      bloodGroup: bloodGroup,
                      requestorName: name,
                      hospital: hospital,
                      quantity: quan,
                    ),
                    SizedBox(height: 20,),

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

class CustomElevated extends StatefulWidget {
  const CustomElevated({
    super.key,
    required this.requestorUid,
    required this.bloodGroup,
    this.requestorName,
    this.hospital,
    this.quantity,
  });

  final String? requestorUid;
  final String bloodGroup;
  final String? requestorName;
  final String? hospital;
  final int? quantity;

  @override
  State<CustomElevated> createState() => _CustomElevatedState();
}

class _CustomElevatedState extends State<CustomElevated> {
  bool _saving = false;

  Future<void> _donate() async {
    final donor = FirebaseAuth.instance.currentUser;
    final messenger = ScaffoldMessenger.of(context);
    if (donor == null || widget.requestorUid == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Please log in again to donate.')),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      await FirebaseFirestore.instance
          .collection('donations')
          .doc('${donor.uid}_${widget.requestorUid}')
          .set({
        'donorUid': donor.uid,
        'donorEmail': donor.email,
        'receiverUid': widget.requestorUid,
        'receiverName': widget.requestorName,
        'bloodGroup': widget.bloodGroup,
        'hospital': widget.hospital,
        'quantity': widget.quantity,
        'status': 'pending',
        'createdAt': FieldValue.serverTimestamp(),
      });
      messenger.showSnackBar(
        const SnackBar(content: Text('Thank you! Your donation offer was sent.')),
      );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save donation: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF900000)),
        elevation: WidgetStateProperty.all<double>(10.0),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
      onPressed: _saving ? null : _donate,
      child: Text(
        _saving ? 'SAVING...' : 'DONATE NOW',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Classy',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
