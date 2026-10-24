import 'package:flutter/material.dart';
import 'package:login/pages/IntroScreen/IntroPageOne.dart';
import 'package:login/pages/IntroScreen/IntroPageThree.dart';
import 'package:login/pages/IntroScreen/IntroPageTwo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:login/Usable Clasees.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  PageController _controller = PageController();
  bool inlastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                inlastPage = (index == 2);
              });
            },
            children: [
              IntroPageOne(),
              IntroPageTwo(),
              IntroPageThree()
            ],
          ),
          Container(
            alignment: Alignment(0,0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomElevated(
                      backgroundColor: Color(0xBEBED565),onPress: (){
                    showDialog(
                        context: context,
                        builder: (context){
                          return Center(child: CircularProgressIndicator());
                        }
                    );
                    Future.delayed(Duration(seconds: 2), () {
                    Navigator.pushNamed(
                      context, '/loginPage',
                    ).then((_) {
                      if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                    });
                    });
                  },
                      borderRadius: 25.0,

                      title: 'SKIP',
                      textColor: Colors.white,
                      fontFamily: 'Classy',
                      fontWeight: FontWeight.bold,
                      elevation: 2
                  ),
                  SmoothPageIndicator(controller: _controller, count: 3,),
                  inlastPage?
                  CustomElevated(
                      backgroundColor: Colors.red.shade800,
                      borderRadius: 25.0,
                      onPress: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return Center(child: CircularProgressIndicator());
                            }
                        );
                        Future.delayed(Duration(seconds: 2), () {
                        Navigator.pushNamed(
                          context, '/loginPage',
                        ).then((_) {
                          if (context.mounted && Navigator.of(context).canPop()) Navigator.of(context).pop();
                        });
                        });
                      },
                      title: 'DONE',
                      textColor: Colors.white,
                      fontFamily: 'Classy',
                      fontWeight: FontWeight.bold,
                      elevation: 2
                  ):
                  CustomElevated(
                      backgroundColor: Color(0x650805FF),
                      borderRadius: 25.0,
                      onPress: (){
                        _controller.nextPage(duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      title: 'NEXT',
                      textColor: Colors.white,
                      fontFamily: 'Classy',
                      fontWeight: FontWeight.bold,
                      elevation: 2
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }
}
