import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart';

import '../theme/appcolors.dart';

class MyNavigation extends StatefulWidget {
  final double underlineX;
  final void Function(int index) selectedMenu;
  final GlobalKey myKey1;
  final GlobalKey myKey2;
  final GlobalKey myKey3;
  final GlobalKey myKey4;
  final GlobalKey myKey5;

  const MyNavigation({
    super.key,
    required this.selectedMenu,
    required this.underlineX,
    required this.myKey1,
    required this.myKey2,
    required this.myKey3,
    required this.myKey4,
    required this.myKey5,
  });

  @override
  State<StatefulWidget> createState() => MyNavigationState();
}

class MyNavigationState extends State<MyNavigation> {
  double? get underlineX => widget.underlineX;
  void Function(int index) get selectedMenu => widget.selectedMenu;
  GlobalKey get _myKey1 => widget.myKey1;
  GlobalKey get _myKey2 => widget.myKey2;
  GlobalKey get _myKey3 => widget.myKey3;
  GlobalKey get _myKey4 => widget.myKey4;
  GlobalKey get _myKey5 => widget.myKey5;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.translate(
      offset: Offset(0, 25),
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.bottomNavigationBarColor),
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
    );
  }
}
