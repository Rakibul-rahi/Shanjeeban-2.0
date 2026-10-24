import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Emergency extends StatefulWidget {
  const Emergency({super.key});

  @override
  State<Emergency> createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade300,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        backgroundColor: Colors.red.shade800,
        title: Text(
          'Emergency Numbers',

        ),
        centerTitle: true,

      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DonateNowList(title: 'স্বাস্থ্য বাতায়ন', subtitle: '16325',
                onPress: () async{
                  showDialog(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator());
                      }
                  );

                  final Uri url = Uri(
                    scheme: 'tel',
                    path: '16325'
                  );
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pop();

                  if (await canLaunchUrl(url)) {
                    print("Launched");
                    await launchUrl(url);
                  }else{
                    print('Cannot Launch');
                  }
                },
              ),
              SizedBox(height: 20,),
              DonateNowList(title: 'Ambulance', subtitle: '999',
                onPress: () async{
                  showDialog(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator());
                      }
                  );

                  final Uri url = Uri(
                      scheme: 'tel',
                      path: '999'
                  );
                  await Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pop();

                  if (await canLaunchUrl(url)) {
                    print("Launched");
                    await launchUrl(url);
                  }else{
                    print('Cannot Launch');
                  }
                },
              ),
              SizedBox(height: 20,),
              DonateNowList(title: 'Information Help',subtitle: '333',
                onPress: () async{
                  showDialog(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator());
                      }
                  );

                  final Uri url = Uri(
                      scheme: 'tel',
                      path: '333'
                  );

                  await Future.delayed(Duration(seconds: 2));
                  Navigator.of(context).pop();
                  if (await canLaunchUrl(url)) {
                    print("Launched");
                    await launchUrl(url);
                  }else{
                    print('Cannot Launch');
                  }
                },
              ),
              SizedBox(height: 20,),

            ],
          
          ),
        ),

    );
  }
}

class DonateNowList extends StatefulWidget {
  const DonateNowList({
    Key? key,
    required this.title, required this.onPress, required this.subtitle, this.sub_subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String? sub_subtitle;
  final VoidCallback onPress;

  @override
  State<DonateNowList> createState() => _DonateNowListState();
}

class _DonateNowListState extends State<DonateNowList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.red.shade600,
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
            color: Colors.red.shade100,
          ),
          child: ClipOval(
            child: Icon(
              Icons.emergency,
              color: Colors.red[600],
            )
          ),
        ),
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Classy',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: Colors.black.withValues(alpha: 0.5),
                  fontFamily: 'Classy',
                  fontSize: 10,
                ),
              ),

            ]
        ),


        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white.withValues(alpha: 0.3),
          ),
          child: Icon(
            LineAwesomeIcons.phone,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}