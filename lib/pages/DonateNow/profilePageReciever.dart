import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RequestedProfile extends StatefulWidget {
  const RequestedProfile({super.key});

  @override
  State<RequestedProfile> createState() => _RequestedProfileState();
}

class _RequestedProfileState extends State<RequestedProfile> {

  @override
  Widget build(BuildContext context) {
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
                  height: 550, width: 300,
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
                        'Abdul Jabbar',
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
                                  onPressed: () {},
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
                            '32',
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
                            'A+',
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
                            'Road Accident',
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
                            '3 Bags',
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
                                    'Better Life Hospital',
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
                      CustomElevated(),
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

class CustomElevated extends StatelessWidget {
  const CustomElevated({
    super.key,
  });

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
      onPressed: (){},
        child: Text(
            'DONATE NOW',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Classy',
            fontWeight: FontWeight.bold,
          ),
        ),
      );
  }
}
