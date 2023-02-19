import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text, {String type = ''}) {
    if (text == null) return;

    final snakBar = SnackBar(
      padding: const EdgeInsets.all(10),
      // margin: const EdgeInsets.all(20),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      duration: const Duration(seconds: 1),
      content: Container(
        // margin: const EdgeInsets.symmetric(vertical: 70),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.inner,
              color: Colors.black12,
              offset: Offset(1, 1),
              blurRadius: 10,
            )
          ],
          color: MyColors.lessBlackColor,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: MyColors.secondaryColor,
            fontFamily: 'Cairo',
            fontSize: 12,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snakBar);
  }
}
