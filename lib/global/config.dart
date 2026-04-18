import 'package:flutter/cupertino.dart';

class NavigationConfig {
  final double underlineX;
  final void Function(int index) selectedMenu;
  final List<GlobalKey> keys;
  NavigationConfig({
    required this.underlineX,
    required this.selectedMenu,
    required this.keys,
  });
}

final List<GlobalKey> keys = List.generate(
  5,
      (_) => GlobalKey(),
);