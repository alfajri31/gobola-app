import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {

  int currentIndex = 0;
  double underlineX = 0;

  final List<GlobalKey> keys = List.generate(5, (_) => GlobalKey());

  void selectedMenu(int index) {
    currentIndex = index;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateUnderline(index);
      notifyListeners();
    });
  }

  void _updateUnderline(int index) {
    final context = keys[index].currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox;
    final pos = box.localToGlobal(Offset.zero);

    underlineX = pos.dx;
  }
}