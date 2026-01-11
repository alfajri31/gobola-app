
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:gobola_app/match/match_screen.dart';
import 'package:gobola_app/news/news_screen.dart';
import 'package:gobola_app/other/others_screen.dart';
import 'package:gobola_app/search/search_screen.dart';
import 'package:gobola_app/service/match_service.dart';
import 'package:gobola_app/theme/appcolors.dart';
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
  List<Widget> pages = [
    MatchScreen(matchService: MatchService(),),
    SearchScreen(),
    NewsScreen(),
    FavoriteScreen(),
    OthersScreen(),
  ];

  int dynamicIndex = 0;
  double underlineX = 18.0;

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

  void selectedMenu(int index) {
    setState(() {
      sliderWidget(index);
      dynamicIndex = index;
    });
  }

  Widget myNavbar(BuildContext context) {
    return Scaffold(
      body: pages[dynamicIndex],
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 25),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.bottomNavigationBarColor,
          ),
          child: Stack(
            children: [
              //for animation not change position
              // AnimatedPositioned(
              //   curve: Curves.easeInOut,
              //   top: 60,
              //   left: underlineX,
              //   duration: Duration(microseconds: 300),
              //   child: Container(height: 3, width: 50, color: Colors.white),
              // ),
              //for animation change based position coordinate should wrapped in stack
              TweenAnimationBuilder(
                tween: Tween<double>(begin: underlineX, end: underlineX),
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.translate(
                    // the offset means x is changed based value and 0 is y that not changed these(x,y) is changed with slow transition
                    offset: Offset(value, 0),
                    child: child,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 60),
                  height: 3,
                  width: 50,
                  color: Colors.white,
                ),
              ),
              BottomNavigationBar(
                onTap: selectedMenu,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                unselectedItemColor: Colors.white,
                selectedItemColor: Colors.white,
                selectedLabelStyle: TextStyle(fontSize: 13),
                unselectedLabelStyle: TextStyle(fontSize: 13),
                items: [
                  BottomNavigationBarItem(
                    key: _myKey1,
                    label: "",
                    icon: Column(
                      children: [
                        Image(
                          height: 32,
                          image: Svg('lib/assets/icons/pertandingan.svg'),
                        ),
                        Text(
                          "Pertandingan",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    key: _myKey2,
                    label: "",
                    icon: Column(
                      children: [
                        Image(
                          height: 32,
                          image: Svg('lib/assets/icons/cari.svg'),
                        ),
                        Text(
                          "Cari",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    key: _myKey3,
                    label: "",
                    icon: Column(
                      children: [
                        Image(
                          height: 32,
                          image: Svg('lib/assets/icons/berita.svg'),
                        ),
                        Text(
                          "Berita",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    key: _myKey4,
                    label: "",
                    icon: Column(
                      children: [
                        Image(
                          height: 32,
                          image: Svg('lib/assets/icons/unfavorite.svg'),
                        ),
                        Text(
                          "Favorit",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    key: _myKey5,
                    label: "",
                    icon: Column(
                      children: [
                        Image(
                          height: 32,
                          image: Svg('lib/assets/icons/lainnya.svg'),
                        ),
                        Text(
                          "Lainnya",
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: myNavbar(context));
  }
}
