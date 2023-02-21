import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> showQToast(String msg, bool isError) async {
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
        ? ToastGravity.CENTER
        : ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: isError
        ? const Color(0xff6d5271).withOpacity(0.85)
        : const Color(0xfff69036).withOpacity(0.85),
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
