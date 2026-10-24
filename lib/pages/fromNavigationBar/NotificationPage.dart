import 'package:flutter/material.dart';

class NotificatoinPage extends StatefulWidget {
  const NotificatoinPage({super.key});

  @override
  State<NotificatoinPage> createState() => _NotificatoinPageState();
}

class _NotificatoinPageState extends State<NotificatoinPage> {
  @override
  Widget build(BuildContext context) {
    //get the notification message and display on screen
    // final message= ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Scaffold(
      body: Center(
        child: Text(
          'Notification Page',
          style: TextStyle(
            fontFamily: 'Classy',
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
