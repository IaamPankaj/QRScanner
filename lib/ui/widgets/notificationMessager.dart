// ignore: file_names
import 'package:flutter/material.dart';

notificationMessager({
  required BuildContext context,
  required String title,
  Color textColor = Colors.white,
  required Color backgroundColor,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      key: GlobalKey(debugLabel: title),
      content: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    ),
  );
}
