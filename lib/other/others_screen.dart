import 'package:flutter/material.dart';

class OthersScreen extends StatefulWidget {
  const OthersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Process();
  }
}

class Process extends State<OthersScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: Scaffold(body: Text("welcome to others screen")));
  }

}