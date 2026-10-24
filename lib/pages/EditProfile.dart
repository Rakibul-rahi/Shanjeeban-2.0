import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF002828),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left, color: Colors.white,),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color:Colors.white,
            fontFamily: 'Classy',
          ),
        ),


      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Container(
                width: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border
                    borderRadius: BorderRadius.circular(8.0), // BorderRadius for rounded corners
                  ),

                  child: TextField(
                    //controller: fullNameInput,
                    decoration: InputDecoration(
                      hintText: "Sadik Rahman",
                      hintStyle: TextStyle(color: Colors.grey.shade600,fontFamily: 'Classy'),
                      border: InputBorder.none,
                      prefixIcon: Icon(LineAwesomeIcons.user_astronaut), // Use Icons.phone for a phone icon
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Container(
                  width: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border
                    borderRadius: BorderRadius.circular(8.0), // BorderRadius for rounded corners
                  ),

                  child: TextField(
                    //controller: fullNameInput,
                    decoration: InputDecoration(
                      hintText: "sadik.nai.008@gmail.com",
                      hintStyle: TextStyle(color: Colors.grey.shade600,fontFamily: 'Classy'),
                      border: InputBorder.none,
                      prefixIcon: Icon(LineAwesomeIcons.mail_bulk), // Use Icons.phone for a phone icon
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Container(
                width: 300,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border
                  borderRadius: BorderRadius.circular(8.0), // BorderRadius for rounded corners
                ),
                child: TextField(
                  //controller: passwordInput,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                      hintText: "**********",
                      hintStyle: TextStyle(color: Colors.grey.shade600,fontFamily: 'Classyl',),
                      border: InputBorder.none,
                      prefixIcon: Icon(LineAwesomeIcons.user_secret)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
