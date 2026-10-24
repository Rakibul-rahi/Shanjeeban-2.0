import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';


class noReciver extends StatefulWidget {
  const noReciver({super.key});

  @override
  State<noReciver> createState() => _noReciverState();
}

class _noReciverState extends State<noReciver> {

  String ?docID;
  String name = "a";
  int ph = 619;
  String em = "c";
  String blood = "rokto";
  String newName = "new";
  String updateName = "new";
  String changeCatcher = "hoynai";
  String thana = "random";
  String district = "gg";

  Future<void> getUserData() async {
    try {
      print(" ");print("get er vitore ");
      print(docID);
      print(" ");print(" ");

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("newUserCredentials").doc(docID).get();
      if (userSnapshot.exists) {
        String userName = userSnapshot['name'];
        int phone = userSnapshot['number'];
        String email = userSnapshot['email'];
        String bGroup = userSnapshot['bloodGroup'];
        String districtt = userSnapshot['district'];
        String thanaa = userSnapshot['thana'];

        setState(() {
          name = userName;
          ph = phone;
          em = email;
          updateName = name;
          changeCatcher = "hoise";
          blood = bGroup + "donor";
          district = districtt;
          thana = thanaa;
        });

        print(" ");print(" ");
        print(name);print(ph);print(em); print("inside getUser");
        print(" ");print(" ");

      } else {
        print(" ");print(" ");
        print("snapshot khuje pay nai");
        print(" ");print(" ");
      }
    } catch (e) {
      print(e);
      print(" ");print(" ");
      print("problem");
      print(" ");print(" ");
    }
  }

  Future<void> storeDonorData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference collectionRef = firestore.collection(blood);

      await collectionRef.add({
        'name': name,
        'email': em,
        'phone': ph,
        'district': district,
        'thana': thana,
        'uid' : docID,
      });

      print(" ");print(" ");
      print('donor info added to collection successfully!');
      print(" ");print(" ");
    } catch (error) {
      print('Error adding data to collection: $error');
    }
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> formData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    docID = formData['docID'];

    if(updateName == newName)
      getUserData();

    if(changeCatcher == "hoise")
      storeDonorData();

    return Scaffold(

        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.blueGrey.shade800,
                  Colors.blueGrey.shade600,
                  Colors.blueGrey.shade400,
                ]
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10,),
              FadeInUp(duration: Duration(milliseconds: 1000),child: Image.asset("assets/images/bg.png", height: 200 , width:200 ,)),
              FadeInUp(duration: Duration(milliseconds: 1000),child: Text('Rakibul', style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'oldschool'),)),
              SizedBox(height: 30,),
              FadeInUp(duration: Duration(milliseconds: 1300),
                child: Container(
                  alignment: Alignment.center,
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Color(0xFFD4E3E1),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      boxShadow: [BoxShadow(
                          color: Colors.red.shade500.withValues(alpha: 0.5),
                          blurRadius: 20,
                          offset: Offset(0, 10)
                      )]
                  ),
                  child: FadeInUp(duration: Duration(milliseconds:2000),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        Text('NOTICE', style: TextStyle(
                          color: Colors.black87,
                          fontSize: 50, fontFamily: 'oldschool', fontWeight: FontWeight.bold,
                        ),


                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Text('Sorry, ', style: TextStyle(
                            fontSize: 30, fontFamily: 'oldschool', fontWeight: FontWeight.bold,
                          ),


                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,10),
                          child: Text(' No Match Found For You', style: TextStyle(

                            fontSize: 30, fontFamily: 'oldschool', fontWeight: FontWeight.bold,
                          ),


                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0,10,10,10),
                          child: Text('We Are Putting You In The Waiting List', style: TextStyle(
                            fontSize: 30, fontFamily: 'oldschool', fontWeight: FontWeight.bold,
                          ),


                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              SizedBox(height: 40,),
              FadeInUp(duration: Duration(milliseconds: 1600),
                child: Container(
                  width: 150,
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context){
                            return Center(child: CircularProgressIndicator());
                          }
                      );

                      Future.delayed(Duration(seconds: 2), () {
                      Navigator.pushNamed(
                          context, '/mainPage',
                        arguments: {
                          'docID': docID,
                        },
                      ).then((_) {
                        if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                      });
                      });

                    },

                    height: 50,
                    // margin: EdgeInsets.symmetric(horizontal: 50),
                    color: Colors.red[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),

                    ),
                    // decoration: BoxDecoration(
                    // ),
                    child: Center(
                      child: Text("HOME", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily: 'oldschool',),),
                    ),
                  ),

                ),
              )
            ],
          ),
        )
    ) ;
  }
}
