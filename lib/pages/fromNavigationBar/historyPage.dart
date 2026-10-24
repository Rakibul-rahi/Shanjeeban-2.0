import 'package:flutter/material.dart';

class HostoryPage extends StatefulWidget {
  const HostoryPage({super.key});

  @override
  State<HostoryPage> createState() => _HostoryPage();
}

class _HostoryPage extends State<HostoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'History Page',
          style: TextStyle(
            fontFamily: 'Classy',
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
