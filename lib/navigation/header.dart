import 'package:flutter/material.dart';

import '../theme/appcolors.dart';

class Header extends StatefulWidget {
  final Widget childWidget1;
  final Widget? childWidget2;

  const Header({
    super.key,
    required this.childWidget1,
    required this.childWidget2,
  });

  @override
  State<StatefulWidget> createState() {
    return HeaderWidget();
  }
}

class HeaderWidget extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.0,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.bottomNavigationBarColor,
              ),
            ),
          ),
          Positioned.fill(child: widget.childWidget1),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(top: 60),
              child: widget.childWidget2!,
            ),
          ),
        ],
      ),
    );
  }
}
