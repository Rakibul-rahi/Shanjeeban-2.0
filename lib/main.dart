import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/firebase_options.dart';
import 'package:login/mainPage.dart';
import 'package:login/pages/Emergency.dart';
import 'package:login/pages/RequestForBlood/donorList.dart';
import 'package:login/pages/base.dart';
import 'package:login/pages/editUserProfile.dart';
import 'package:login/pages/forgot_pass.dart';
import 'package:login/pages/leaderboard/Distribution.dart';
import 'package:login/pages/leaderboard/PointsScreen.dart';
import 'package:login/pages/IntroScreen/onboarding_screen.dart';
import 'package:login/pages/donorProfile.dart';
import 'package:login/pages/requestorProfile.dart';
import 'package:login/rakibul/noDonor.dart';
import 'package:login/pages/DonateNow/profilePageReciever.dart';
import 'package:login/pages/RequestForBlood/requestPage.dart';
import 'package:login/rakibul/noReceiver.dart';
import 'Smj/Physical_Informtion.dart';
import 'api/firebase_api.dart';
import 'deGea/signUpInfo.dart';
import 'rakibul/loginPage.dart';
import 'pages/fromNavigationBar/home_page.dart';
import 'pages/profilePage.dart';
import 'package:login/pages/DonateNow/recieversList.dart';
import 'package:login/pages/RequestForBlood/donatorsList.dart';
import 'package:login/pages/RequestForBlood/profilePageDonators.dart';
import 'package:login/pages/DonateNow/requestorList.dart';
final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await Firebase_api().initNotifications();
  } catch (e) {
    // Push notifications are optional; never block app start (e.g. web/no permission).
    debugPrint('Notification setup failed: $e');
  }



  User? currentUser = FirebaseAuth.instance.currentUser;
  if(currentUser != null){
    runApp(MyApp());
  }
  else{
    runApp(toLogin());
  }
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,


      home: MainPage(),
      navigatorKey: navigatorKey,


      routes: {
        '/mainPage':(context) => MainPage(),
        '/loginPage':(context) => loginPage(),
        '/signUpPage':(context) => signUpInfo(),
        '/homePage':(context) => Home(),
        '/physical':(context) => PhysicalInformationPage(),
        '/userProfile':(context) => Profile(),
        '/donatorsProfile':(context) => DonatorsProfile(),
        '/requestedProfile':(context) => RequestedProfile(),
        '/donatorsList':(context) => DonatorsListPage(),
        '/recieversList':(context) => DonateNow(),
        '/requestForm' : (context) => BloodRequestForm(),
        '/everyRequest' : (context) => RequestorList(),
        '/requestorProfile' : (context) => RequestorProfile(),
        '/noReciever' : (context) => noReciver(),
        '/allDonors' : (context) => donorList(),
        '/noDonor' : (context) => noDonor(),
        '/donorProfile'  : (context) => donorProfile(),
        '/emergency'  : (context) => Emergency(),
        '/pointScreen'  : (context) => PointsScreen(),
        '/distributiion'  : (context) => Distribution(),
        '/editUserProfile'  : (context) => editUserProfile(),
        '/onBoarding'  : (context) => OnBoardingScreen(),
        '/forgotPass'  : (context) => ForgotPassword(),
    },
    );
  }
}


class toLogin extends StatefulWidget {
  const toLogin({super.key});

  @override
  State<toLogin> createState() => _toLoginState();
}

class _toLoginState extends State<toLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: BaseScreen(),

      routes: {
        '/mainPage':(context) => MainPage(),
        '/loginPage':(context) => loginPage(),
        '/signUpPage':(context) => signUpInfo(),
        '/homePage':(context) => Home(),
        '/physical':(context) => PhysicalInformationPage(),
        '/userProfile':(context) => Profile(),
        '/donatorsProfile':(context) => DonatorsProfile(),
        '/requestedProfile':(context) => RequestedProfile(),
        '/donatorsList':(context) => DonatorsListPage(),
        '/recieversList':(context) => DonateNow(),
        '/requestForm' : (context) => BloodRequestForm(),
        '/everyRequest' : (context) => RequestorList(),
        '/requestorProfile' : (context) => RequestorProfile(),
        '/noReciever' : (context) => noReciver(),
        '/allDonors' : (context) => donorList(),
        '/noDonor' : (context) => noDonor(),
        '/donorProfile'  : (context) => donorProfile(),
        '/emergency'  : (context) => Emergency(),
        '/pointScreen'  : (context) => PointsScreen(),
        '/distributiion'  : (context) => Distribution(),
        '/onBoarding'  : (context) => OnBoardingScreen(),
        '/editUserProfile'  : (context) => editUserProfile(),
        '/forgotPass'  : (context) => ForgotPassword(),
      },
    );
  }
}



