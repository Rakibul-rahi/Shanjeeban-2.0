import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:login/main.dart';


class Firebase_api {
  //create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
  Future<void> initNotifications() async {
    //request permission from use (will prompt user)
    await _firebaseMessaging.requestPermission();
    Future<void> getFCMToken() async {
      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        print('FCM Token: $fcmToken');
        await FirebaseMessaging.instance.subscribeToTopic('all_users');
      } catch (e) {
        // getToken/subscribeToTopic fail on web (no VAPID key) and when offline.
        print('FCM setup skipped: $e');
      }
    }
    getFCMToken();
    //fetch the FCM token for this device
    Future<void> storeFCMToken(String userId, String fcmToken) async {
      await FirebaseFirestore.instance.collection('newUserCredentials').doc(userId).update({
        'fcmToken': fcmToken,
      });
    }
    // Example during user registration or login
    void handleUserAuthentication(String userId) async {
      await getFCMToken(); // Get FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await storeFCMToken(userId, fcmToken); // Store FCM token in Firestore
      }
    }

    //initialize further settings for push noti
    initPushNotifications();




  }
  //function to requestPermission
  /*void requestPermission() async {
    FirebaseMessaging messaging=FirebaseMessaging.instance;
    NotificationSettings settings= await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    } else {
      print('user declined or has not accepted permission');
    }
  }*/


  //function to handle received messages
  void handleMessage(RemoteMessage? message){
    //if the message is null, do nothing
    if(message==null)return;
    //navigate to new screen when message is received and use taps notification
    navigatorKey.currentState?.pushNamed(
      'noReciver()',
      arguments: message,
    );

  }

  //funtion to initialize foreground and bakground settings
  Future initPushNotifications() async {
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }





}
