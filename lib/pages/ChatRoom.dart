import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ChatRoom extends StatefulWidget {



  /*final UserModel targetuser;
  final ChatRoomModel chatRoom;
  final UserModel userModel;
  final User firebaseuser;*/



 // ChatRoom({super.key, required this.targetuser, required this.chatRoom, required this.userModel, required this.firebaseuser});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  String docID = "ggh";
  String ?name;

  Future<void> getUserData() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection("userCredentials").doc(docID).get();
      if (userSnapshot.exists) {
        String userName = userSnapshot['name'];



        setState(() {
          name = userName;
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Sadik Rahman',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container()
              ),

              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 5
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Message...",
                          ),
                        )
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.send, color: Colors.blue[500],)
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
