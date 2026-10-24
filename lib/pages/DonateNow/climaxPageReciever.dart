import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login/Usable%20Clasees.dart';

class Climax extends StatefulWidget {
  const Climax({super.key});

  @override
  State<Climax> createState() => _ClimaxState();
}

class _ClimaxState extends State<Climax> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedReason;

  final List<String> reasons = [
    'Health Conditions',
    'Medications',
    'Travel History',
    'Recent Blood Donation',
    'Weight and Age Requirements',
    'Pregnancy and Breastfeeding',
    'Risk Behaviors',
    'Hemoglobin Levels',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: (){

          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(
              'Reward the Donor'
          ),
      ),
      backgroundColor: Color(0xFFD4E3E1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
              height: 250,
              decoration: BoxDecoration(
                color: Color(0xFFADD1CD),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Text(
                      'We will take your few seconds',
                    style: TextStyle(
                      fontFamily: 'Classy',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'to inspire the Donor...',
                    style: TextStyle(
                      fontFamily: 'Classy',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomElevated(
                        backgroundColor: Colors.red.shade900,
                        borderRadius: 25,
                        onPress: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.grey[400],

                                title: Text(
                                    'Just Few More Seconds',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Classy',
                                  ),
                                ),

                                actions: [
                                   Form(
                                     key: _formKey,
                                     child: DropdownButtonFormField(
                                       value: _selectedReason,
                                         items: reasons.map((reason){
                                           return DropdownMenuItem(
                                             value: reason,
                                             child: Text(reason),
                                           );
                                         }).toList(),
                                       onChanged: (value) {
                                         setState(() {
                                           _selectedReason = value;
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
                                         labelText: 'Reason of Failure',
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
                                           return 'Please select a reason';
                                         }
                                         return null;
                                       },
                                   ),
                                   ),
                                  SizedBox(height: 20,),
                                  CustomElevated(

                                      backgroundColor: Colors.red.shade800,
                                      borderRadius: 25,
                                      onPress: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return Center(child: CircularProgressIndicator());
                                            }
                                        );
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          print('Reason of Failure: $_selectedReason');
                                          print('LessGo Home Page');
                                        }
                                        Future.delayed(Duration(seconds: 1), () {
                                        Navigator.pushNamed(context, '/mainPage'
                                        ).then((_) {
                                          if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                                        });
                                        });
                                      },
                                      title: 'SUBMIT',
                                      textColor: Colors.white,
                                      fontFamily: 'Classy',
                                      fontWeight: FontWeight.bold,
                                      elevation: 5,
                                  )
                                ],
                              );
                            });
                        },
                        title: 'CANCELED',
                        textColor: Colors.white,
                        fontFamily: 'Classy',
                        fontWeight: FontWeight.bold,
                        elevation: 5,
                      ),
                      SizedBox(width: 20,),
                      CustomElevated(
                        backgroundColor: Colors.green.shade800,
                        borderRadius: 25,
                        onPress: (){

                        },
                        title: 'RECIEVED',
                        textColor: Colors.white,
                        fontFamily: 'Classy',
                        fontWeight: FontWeight.bold,
                        elevation: 5,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

