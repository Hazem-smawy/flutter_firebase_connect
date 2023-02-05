import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class ShowToast {
  static showToast(String msg, String type) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: type == "error" ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
