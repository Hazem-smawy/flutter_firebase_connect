import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class ClientUtilities {
  static final messengerKey = Utils.messengerKey;

  static showSnackBarWidget(String? text, {String type = ''}) {
    if (text == null) return;

    final snakBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          color: MyColors.bg,
          fontFamily: 'Cairo',
          fontSize: 14,
        ),
      ),
      backgroundColor: MyColors.primaryColor,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snakBar);
  }
}
