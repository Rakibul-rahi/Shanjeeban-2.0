import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'recieversList.dart';


class RequestorList extends StatefulWidget {
  @override
  _RequestorListState createState() => _RequestorListState();
}

class _RequestorListState extends State<RequestorList> {
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

    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator());
        }
    );
    Future.delayed(Duration(seconds: 1), () {
    Navigator.pushNamed(
      context, '/requestorProfile',
      arguments: {
        'requestorUid' : requestorUid,
        'docId' : docID,
        'bloodGroup' : bloodGroup,
      },
    ).then((_) {
      if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
    });
    });
  }

  String docID = "gg";
  String bloodGroup = "nothing";

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot3 =
      await FirebaseFirestore.instance.collection("newUserCredentials").doc(docID).get();
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
    try {
      final Map<String, dynamic>? args =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args.containsKey('docID')) {
        docID = args['docID'];

        getUserData();
      }
    } finally {
      print(bloodGroup);
      print("aaa ");
      print("aaa ");
      bloodRequests = FirebaseFirestore.instance.collection(bloodGroup);

      return Scaffold(
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
          child: StreamBuilder<QuerySnapshot>(
            stream: bloodRequests.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              var documents = snapshot.data!.docs;

              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 20),
                      for (var document in documents)
                        Center(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {

                                },
                                child: DonateNowList(
                                    title: '${document['name']}',
                                    onPress: () {
                                      onPersonClicked(document['uid']);
                                    },
                                    subtitle: '${document['reason']}',
                                    sub_subtitle: '${document['quantity']}  bags'
                                )
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),



                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}