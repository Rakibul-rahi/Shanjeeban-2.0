import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Usable Clasees.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  /*Future passwordReset() async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: )
  }*/
  @override
  Widget build(BuildContext context) {

    final emailcontroller = TextEditingController();
    final auth = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: Colors.red.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Classy'),
        ),
        backgroundColor: Colors.red.shade800,
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 400,
          
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.red.shade800,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Give E-mail to set new Password',
                    hintStyle: TextStyle(
                      color: Colors.white,
                        fontFamily: 'Classy'
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true,
                    fillColor: Colors.red.shade600,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 15,
                    ),

                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.white,
                        size: 15,
                      ),
                      onPressed: () {
                          emailcontroller.clear();
                      },
                    ),


                  ),


                ),
              ),
              CustomElevated(
                  backgroundColor: Colors.red.shade800,
                  borderRadius: 25,
                  onPress: () {
                    auth.sendPasswordResetEmail(email: emailcontroller.text.toString())
                        .then((value) {
                            Utils().toastMessage("Mail Sent");
                    }).onError((error, stackTrace){
                      Utils().toastMessage(error.toString());
                    });
                  },
                  title: "Send",
                  textColor: Colors.white,
                  fontFamily: 'Classy',
                  fontWeight: FontWeight.normal,
                  elevation: 2
              )

            ],
          ),
        ),
      ),
    );
  }
}
class Utils {
  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}