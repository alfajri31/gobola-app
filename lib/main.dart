import 'package:flutter/material.dart';
import 'package:gobola_app/match/match_screen.dart';
import 'package:gobola_app/navigation/my_navigation.dart';
import 'package:gobola_app/news/news_screen.dart';
import 'package:gobola_app/other/others_screen.dart';
import 'package:gobola_app/search/search_screen.dart';
import 'package:gobola_app/service/match_service.dart';
import 'favourite/favorite_screen.dart';

GlobalKey _myKey1 = GlobalKey();
GlobalKey _myKey2 = GlobalKey();
GlobalKey _myKey3 = GlobalKey();
GlobalKey _myKey4 = GlobalKey();
GlobalKey _myKey5 = GlobalKey();

void main() {
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
  int dynamicIndex = 0;
  double underlineX = 18.0;

  void selectedMenu(int index) {
    setState(() {
      sliderWidget(index);
      dynamicIndex = index;
    });
  }

  void sliderWidget(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = _myKey1;
        break;
      case 1:
        targetKey = _myKey2;
        break;
      case 2:
        targetKey = _myKey3;
        break;
      case 3:
        targetKey = _myKey4;
        break;
      case 4:
        targetKey = _myKey5;
        break;
      default:
        return;
    }
    final renderBox = targetKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      underlineX = position.dx + 18.0;
    });
  }

  List<Widget> pages = [
    MatchScreen(matchService: MatchService()),
    SearchScreen(),
    NewsScreen(),
    FavoriteScreen(),
    OthersScreen(),
  ];

  Widget myNavbar(BuildContext context) {
    return Scaffold(
      body: pages[dynamicIndex],
      bottomNavigationBar: MyNavigation(
        selectedMenu: selectedMenu,
        underlineX: underlineX,
        myKey1: _myKey1,
        myKey2: _myKey2,
        myKey3: _myKey3,
        myKey4: _myKey4,
        myKey5: _myKey5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: myNavbar(context));
  }
}
