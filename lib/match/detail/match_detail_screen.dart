import 'package:flutter/material.dart';
import '../../utility/header.dart';

class MatchDetailScreen extends StatelessWidget {
  const MatchDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(
          childWidget1: Stack(
            children: [
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("Kembali", style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text(
                        "Title League",
                        style: TextStyle(color: Colors.white),
                      ),
                      Spacer(),
                      Text("Favorit", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          childWidget2: Stack(
            children: [
              Align(alignment: Alignment.centerLeft, child: Text("team 1")),
              Align(alignment: Alignment.center, child: Text("Score")),
              Align(alignment: Alignment.centerRight, child: Text("Score")),
            ],
          ),
        ),
      ],
    );
  }
}
