import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Constants {
  static Color morning = const Color(0xFF7DB0F1);
  static Color evening = const Color(0xFF4D7DB4);
  static Color night = const Color(0xFF213F61);
  static Color sun = const Color(0xFFFFCE49);
  static Color snow = const Color(0xFFF3E5AB);
  static Color onDark = const Color(0xFFF3F3F3);
  static Color darkBackground = const Color(0xFF272727);
  static Color cardOnDark = const Color(0xFF363636);
  static String font1 = "Font1";
  static double defaultPadding = 20;
  static double borderRaduis = 15;
  static int darkTheme = 1;

  Text text(String text, double size) {
    return Text(
      text,
      style: TextStyle(
        color: Constants.onDark,
        fontFamily: Constants.font1,
        fontSize: size,
      ),
    );
  }

  IconButton iconButton(IconData icon, Function? Function() onPressed) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: FaIcon(
        icon,
        color: darkTheme == 1 ? Constants.onDark : Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
