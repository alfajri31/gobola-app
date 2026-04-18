import 'package:flutter/material.dart';
import 'package:gobola_app/theme/appcolors.dart';

class SwitchToggle extends StatefulWidget {
  const SwitchToggle({super.key});

  @override
  State<SwitchToggle> createState() => _SwitchToggleState();
}

class _SwitchToggleState extends State<SwitchToggle> {
  bool isOn = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      //container background toggle switch transparan
      child: Container(
        width: 75,
        height: 90,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => setState(() => isOn = !isOn),
          child: SizedBox(
            width: 40,
            height: 26,
            child: Stack(
              alignment: Alignment.center,
              children: [
                //ini bagian yang panjangnya
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.tosca,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                //ini bagian yang bulet nya
                AnimatedAlign(
                  duration: const Duration(milliseconds: 180),
                  alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: AppColors.tosca,
                      shape: BoxShape.circle
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
