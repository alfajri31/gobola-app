import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';
import 'package:gobola_app/global/config.dart';

import '../favourite/favorite_screen.dart';
import '../match/match_screen.dart';
import '../news/news_screen.dart';
import '../other/others_screen.dart';
import '../search/search_screen.dart';
import '../service/match_service.dart';
import '../theme/appcolors.dart';

class MyNavigation extends StatefulWidget {
  final bool stay;
  final Widget page;

  const MyNavigation({super.key, required this.stay, required this.page});

  @override
  State<StatefulWidget> createState() => MyNavigationState();
}

class MyNavigationState extends State<MyNavigation> {
  final NavigationConfig navigationConfig = NavigationConfig();

  int dynamicIndex = 0;
  double underlineX = 18.0;

  late var stay = widget.stay;

  void selectedMenu(int index) {
    setState(() {
      sliderWidget(index);
      dynamicIndex = index;
      stay = false;
    });
  }

  void sliderWidget(int index) {
    GlobalKey targetKey;
    switch (index) {
      case 0:
        targetKey = navigationConfig.myKey1;
        break;
      case 1:
        targetKey = navigationConfig.myKey2;
        break;
      case 2:
        targetKey = navigationConfig.myKey3;
        break;
      case 3:
        targetKey = navigationConfig.myKey4;
        break;
      case 4:
        targetKey = navigationConfig.myKey5;
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> pages = [
      MatchScreen(matchService: MatchService()),
      SearchScreen(),
      NewsScreen(),
      FavoriteScreen(),
      OthersScreen(),
    ];

    return Scaffold(
      // body: widget.isStay ? pages[dynamicIndex] : SizedBox(),
      body: !stay ? pages[dynamicIndex] : widget.page,
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
                    key: navigationConfig.myKey1,
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
                    key: navigationConfig.myKey2,
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
                    key: navigationConfig.myKey3,
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
                    key: navigationConfig.myKey4,
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
                    key: navigationConfig.myKey5,
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
}
