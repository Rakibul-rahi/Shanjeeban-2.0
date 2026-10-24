import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class BloodRequestForm extends StatefulWidget {
  @override
  _BloodRequestFormState createState() => _BloodRequestFormState();
}

class _BloodRequestFormState extends State<BloodRequestForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBloodGroup;
  int? _quantity;
  String? _selectedReason;
  String? _selectedHospital;
  String name = "a";
  int ph = 619;
  int age = 2441139;
  String em = "c";
  String newName = "new";
  String updateName = "new";
  String ?docID;


  Future<void> checkIfDonorAvailable({required String bloodGroup}) async {

  }

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
        String userhandle = userSnapshot['handle'];
        String userbloodGroup = userSnapshot['bloodGroup'];
        String userdistrict = userSnapshot['district'];
        String userthana = userSnapshot['thana'];
        int userAge = userSnapshot['age'];


        setState(() {
          name = userName;
          ph = phone;
          em = email;
          updateName = name;
          age = userAge;
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

  void proceed ({required String rokto, required String karon, required String hashpatal, required int koyBag}) async {
    String donorCheck = rokto + "donor";
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionRef = firestore.collection(donorCheck);

    QuerySnapshot querySnapshot = await collectionRef.get();

    print(" ");print(" blood donor");
    print(donorCheck);
    print(" ");print(" ");

    showDialog(
        context: context,
        builder: (context){
          return Center(child: CircularProgressIndicator());
        }
    );

    if (querySnapshot.docs.isNotEmpty) {
      Future.delayed(Duration(seconds: 2), () async {

        User? currentUser = FirebaseAuth.instance.currentUser;
        String? uid;

        if (currentUser != null) {
          uid = currentUser.uid;
        }

        Map <String, dynamic> vampireDemands = {
          "bloodGroup" : rokto,
          "reason" : karon,
          "hospital" : hashpatal,
          "quantity" : koyBag,
          "name" : name,
          "phone" : ph,
          "email" : em,
          "age" : age,
          "uid" : uid,
        };

        // FirebaseFirestore.instance.collection(rokto).add(vampireDemands);

        DocumentReference documentReference4 = await FirebaseFirestore.instance.collection(rokto).doc(uid);
        await documentReference4.set(vampireDemands)
            .then((value) {
          print("Document added successfully!");
          docID = uid;
          print("Document ID: $uid");
        })
            .catchError((error) {
          print("Error adding document: $error");
        });

        print(" ");print(" ");
        print("blood reciever added to waiting list");
        print(" ");print(" ");

      Navigator.pushNamed(
        context, '/allDonors',
        arguments: {
          'docID': docID,
          'blood' : rokto,
        },
      ).then((_) {
        if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
      });
      });
    } else {

      User? currentUser = FirebaseAuth.instance.currentUser;
      String? uid;

      if (currentUser != null) {
        uid = currentUser.uid;
      }

      try {
        Map <String, dynamic> vampireDemands = {
          "bloodGroup" : rokto,
          "reason" : karon,
          "hospital" : hashpatal,
          "quantity" : koyBag,
          "name" : name,
          "phone" : ph,
          "email" : em,
          "age" : age,
          "uid" : uid,
        };

        // FirebaseFirestore.instance.collection(rokto).add(vampireDemands);

        DocumentReference documentReference4 = await FirebaseFirestore.instance.collection(rokto).doc(uid);
        await documentReference4.set(vampireDemands)
            .then((value) {
          print("Document added successfully!");
          docID = uid;
          print("Document ID: $uid");
        })
            .catchError((error) {
          print("Error adding document: $error");
        });

        print(" ");print(" ");
        print("blood reciever added to waiting list");
        print(" ");print(" ");

      } on FirebaseAuthException catch (ex) {
        print(ex.code.toString());
      }
      Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(
        context, '/noDonor',
        arguments: {
          'docID': docID,
        },
      ).then((_) {
        if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
      });
      });
    }

  }


  List<String> _bloodGroups = ['A+', 'A-', 'B+','B-', 'AB+','AB-', 'O+','O-'];
  List<String> _transfusionReasons = [
    'Autoimmune Disorders',
    'Blood Disorders',
    'Bone Marrow Diseases',
    'Cancer Treatment',
    'Genetic Disorders',
    'Infections',
    'Liver Diseases',
    'Loss of Blood',
    'Medical Conditions Affecting Blood Production',
    'Surgery',
  ];
  List<String> _hospitalNames = [
    'Aalok Healthcare & Hospital Ltd.',
    'Al Razi Hospital',
    'Al- Helal Specialized Hospital Limited',
    'Anwer Khan Modern Hospital Limited',
    'Apollo Hospitals Dhaka',
    'Asgar Ali Hospital',
    'Bangladesh Eye Hospital',
    'Bangladesh Specialized Hospital',
    'Banani Clinic Limited (Specialized Hospital)',
    'BRB Hospitals Limited',
    'Care Medical College & Hospital',
    'Central Hospital Cox\'s Bazar (Near Girls School)',
    'Central Hospital Limited',
    'City Hospital Ltd.',
    'Cure Medical Center',
    'Delta Hospital Limited',
    'Digital Hospital Cox\'s Bazar Pvt. Ltd.',
    'Dhaka City Physiotherapy Hospital',
    'Epic Health Care Limited',
    'Farazy Hospital Limited',
    'Green Life Hospital',
    'Hi-care General Hospital',
    'HITECH Multicare Hospital Ltd.',
    'Holy Family Red Crescent Medical College Hospital',
    'Ibn Sina',
    'Ibn Sina Medical College Hospital',
    'Ibn Sina Specialized Hospital',
    'Impulse Hospital Limited',
    'Insaf Barakah Kidney & General Hospital',
    'Islami Bank Central Hospital',
    'Islami Bank Hospital Mirpur',
    'Islami Bank Hospital Mugda',
    'Islami Bank Hospital Motijheel',
    'Islami Bank Specialized & General Hospital Nayapalton',
    'Japan Bangladesh Friendship Hospital',
    'Kingston Hospital Limited',
    'Labaid Cardiac Hospital',
    'Labaid Group',
    'Labaid Specialized Hospital',
    'Life Care Medical Center',
    'Lubana General Hospital (Pvt.) Limited',
    'Max Hospital Limited',
    'MH Samorita Hospital and Medical College-Tejgoan',
    'Monowara Hospital (Pvt.) Ltd',
    'Praava Health',
    'Prescription Point Limited',
    'Prescription Point Limited (Badda Branch)',
    'Prescription Point Limited (Specialized Clinic)',
    'Rifat\'s Dental',
    'Salauddin Medical College',
    'Samorita Hospital Limited',
    'Sheikh Fazilatunnesa KPJ',
    'SIBL Foundation Hospital',
    'Surecell Medical Service (BD) Ltd.',
    'Thyrocare',
    'Uttara Crescent Hospital',
    'United Hospitals Limited',
  ];
  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    docID = args['docID'];
    
    print(" ");print("docID printing  ");
    print(docID);
    print(" ");print(" ");

    try {
      if(updateName == newName)
        getUserData();
    } finally {
      print(" ");print("name, phone email after function call ");
      print(name);print(ph);print(em);
      print(" ");print(" ");

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
          title: Text('Blood Donation Form'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),

              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text(
                          'REQUEST FOR BLOOD',
                          style: TextStyle(
                            fontFamily: 'Classy',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF900000),
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 25,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonFormField(
                            value: _selectedBloodGroup,
                            items: _bloodGroups.map((group) {
                              return DropdownMenuItem(
                                value: group,
                                child: Text(group),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBloodGroup = value as String;
                              });
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.arrow_drop_down,
                                  color: Colors.black,
                                )
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFADC4C1),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 10.0,
                                  )
                              ),
                              labelText: 'Blood Group',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Classy',
                              ),
                              prefixIcon: Icon(
                                Icons.bloodtype,
                                color: Colors.red[900],
                              ),

                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a blood group';
                              }
                              return null;
                            },
                          ),

                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonFormField(
                            value: _selectedReason,
                            items: _transfusionReasons.map((reason) {
                              return DropdownMenuItem(

                                value: reason,
                                child: Text(reason),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedReason = value as String;
                              });
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.arrow_drop_down,
                                  color: Colors.black,
                                )
                            ),
                            decoration: InputDecoration(

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Color(0xFFADC4C1),
                              labelText: 'Reason for Blood Transfusion',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Classy',
                              ),
                              prefixIcon: Icon(
                                Icons.error,
                                color: Colors.red[900],
                              ),

                            ),
                            isExpanded: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a reason for blood transfusion';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: DropdownButtonFormField(
                            value: _selectedHospital,
                            items: _hospitalNames.map((hospital) {
                              return DropdownMenuItem(
                                value: hospital,
                                child: Text(hospital),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHospital = value as String;
                              });
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.withValues(alpha: 0.5),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(Icons.arrow_drop_down,
                                  color: Colors.black,
                                )
                            ),
                            decoration: InputDecoration(

                              filled: true,
                              fillColor: Color(0xFFADC4C1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 10.0,
                                ),
                              ),
                              labelText: 'Hospital Name',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Classy',
                              ),
                              prefixIcon: Icon(Icons.local_hospital_sharp,
                                color: Colors.red[900],
                              ),


                            ),

                            isExpanded: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a hospital';
                              }
                              return null;
                            },
                          ),
                        ),

                        SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFADC4C1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: 'Quantity',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Classy',
                              ),
                              prefixIcon: Icon(
                                Icons.numbers_sharp,
                                color: Colors.red[900],
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a quantity';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _quantity = int.tryParse(value ?? ''); // Provide a default value if value is null
                            },


                          ),
                        ),
                        SizedBox(height: 25.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Color(0xFF900000)),
                            elevation: WidgetStateProperty.all<double>(10.0),
                            shape: WidgetStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              print('Blood Group: $_selectedBloodGroup');
                              print('Reason for Transfusion: $_selectedReason');
                              print('Current Address: $_selectedHospital');
                              print('Quantity: $_quantity');

                              String blood = _selectedBloodGroup!;
                              String reason = _selectedReason!;
                              String hospital = _selectedHospital!;
                              int quantity = _quantity!;

                              proceed(
                                rokto: blood,
                                karon: reason,
                                hashpatal: hospital,
                                koyBag: quantity,
                              );
                            }
                          },
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Classy',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }


  }
}


// onPressed: () {
// proceed(
// cha: line,
// name: name,
// pass: pass,
// number: number,
// email: email,
// handle: handle,
// dateOfBirth: dateOfBirth,
// district: district,
// thana: thana,
// );
// },
// onPressed: () {
// if (_formKey.currentState!.validate()) {
// _formKey.currentState!.save();
//
// // Process the form data
// // For example, you can print the values:
// print('Blood Group: $_selectedBloodGroup');
// print('Reason for Transfusion: $_selectedReason');
// print('Current Address: $_selectedHospital');
// print('Quantity: $_quantity');
//
// String? blood = _selectedBloodGroup;
// String? reason = _selectedReason;
// String? hospital = _selectedHospital;
// int? quantity = _quantity;
//
// Map <String, dynamic> vampireDemands = {
// "blood" : blood,
// "reason" : reason,
// "hospital" : hospital,
// "quantity" : quantity,
// };
//
// DocumentReference docRef = await FirebaseFirestore.instance.collection(blood).doc(email);
// await documentReference1.set(userData)
//     .then((value) {
// print("Document added successfully!");
// docID = email;
// print("Document ID: $docID");
// })
//     .catchError((error) {
// print("Error adding document: $error");
// });
//
// Navigator.pushNamed(context, '/donatorsList');
// }
// },