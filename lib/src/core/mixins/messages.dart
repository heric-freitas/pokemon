import 'package:flutter/material.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    _showSnackbar(
      SnackBarProperties(
        backgroundColor: Colors.redAccent,
        fontColor: Colors.white,
        title: message,        
      ),
    );
  }

  void showWarning(String message) {
    _showSnackbar(
      SnackBarProperties(
        backgroundColor: const Color(0xFFED9E00),
        fontColor: Colors.white,
        title: message,        
      ),
    );
  }

  void showInfo(String message) {
    _showSnackbar(
      SnackBarProperties(
        backgroundColor: Colors.blueGrey,
        fontColor: Colors.white,
        title: message,        
      ),
    );
  }

  void showSuccess(String message) {
    _showSnackbar(
      SnackBarProperties(
        backgroundColor: Colors.green,
        fontColor: Colors.white,
        title: message,        
      ),
    );
  }

  void _showSnackbar(SnackBarProperties content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: content.backgroundColor,
        content: Text(
          content.title,
          style: TextStyle(
            color: content.fontColor,
          ),
        ),
      ),
    );
  }
}

class SnackBarProperties {
  final Color backgroundColor;
  final String title;
  final Color fontColor;

  SnackBarProperties({
    required this.backgroundColor,
    required this.title,
    required this.fontColor,
  });
}