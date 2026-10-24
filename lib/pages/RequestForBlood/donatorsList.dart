import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class DonatorsListPage extends StatefulWidget {
  const DonatorsListPage({super.key});

  @override
  State<DonatorsListPage> createState() => _DonatorsListPageState();
}
                                           // AFTER FILLING THE REQUEST FOR BLOOD FORM
class _DonatorsListPageState extends State<DonatorsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD4E3E1),
      appBar:  AppBar(
        backgroundColor: Color(0xFFADD1CD),
        leading: IconButton(
          onPressed: (){
              Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        title: Text(
          'Donators List',
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Column(

                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Text(
                      'DONATORS AVAILABLE!',
                      style: TextStyle(
                        color: Color(0xFF900000),
                        fontSize: 25,
                        fontFamily: 'Classy',
                        fontWeight: FontWeight.bold,
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Abdul Jabbar', subtitle: '353/17 Hatirjheel Link Road, Wireless, Mogbazar',
                      onPress: (){
                         Navigator.pushNamed(context, '/donatorsProfile');
                      }),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Rafiq Islam', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                  DonatorsList(title: 'Mujibur Rahman', subtitle: 'Address', onPress: (){Navigator.pushNamed(context, '/donatorsProfile');}),
                  SizedBox(height: 20,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class DonatorsList extends StatefulWidget {
  const DonatorsList({
    Key? key,
    required this.title, required this.onPress, required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final VoidCallback onPress;

  @override
  State<DonatorsList> createState() => _DonatorsListState();
}

class _DonatorsListState extends State<DonatorsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Color(0xFFADC4C1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Color(0xFF900000),
          width: 2.0,

        ),

      ),
      child: ListTile(

        onTap: widget.onPress,
        leading: Container(

          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Color(0xFFADC4C1),
          ),
          child: ClipOval(
            child: Image(
              height: 40,
              image: AssetImage(
                'assetsSadik/Profile.jpg',

              ),
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Classy',
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: TextStyle(
            color: Colors.black.withValues(alpha: 0.5),
            fontFamily: 'Classy',
          ),
        ),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withValues(alpha: 0.3),
          ),
          child: Icon(
            LineAwesomeIcons.angle_right,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}