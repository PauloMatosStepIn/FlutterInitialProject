import 'package:flutter/material.dart';

Future<dynamic> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  String? cancelActionText,
  required String defaultActionText,
}) {
  //if (!Platform.isIOS) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                if(cancelActionText != null)
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(cancelActionText)),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(defaultActionText)),
              ],
            ));
  //}
}
