import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {String type = ''}) {
    if (text == null) return;

    final snakBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: MyColors.bg,
          fontFamily: 'Cairo',
          fontSize: 14,
        ),
      ),
      backgroundColor: type == '' ? Colors.red : Colors.green,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snakBar);
  }
}
