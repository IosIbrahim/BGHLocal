import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ToastExtension on BuildContext {
  void showSuccessToast(String message) {
    _showToast(message, Colors.green);
  }

  void showErrorToast(String message) {
    _showToast(message, Colors.red);
  }

  void showInfoToast(String message) {
    _showToast(message, Colors.blue);
  }

  void _showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
