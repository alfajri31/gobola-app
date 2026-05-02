import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gobola_app/HttpOverride.dart';
import 'package:gobola_app/match/match_screen.dart';
import 'package:gobola_app/navigation/my_navigation.dart';
import 'package:gobola_app/news/news_screen.dart';
import 'package:gobola_app/other/others_screen.dart';
import 'package:gobola_app/search/search_screen.dart';
import 'package:gobola_app/service/match_service.dart';
import 'favourite/favorite_screen.dart';

void main() {
  HttpOverrides.global = HttpOverride();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Process();
  }
}

class Process extends State<MyApp> {
  Widget myNavbar(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyNavigation(
        stay: false,
        page: MyApp()
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: myNavbar(context));
  }
}
