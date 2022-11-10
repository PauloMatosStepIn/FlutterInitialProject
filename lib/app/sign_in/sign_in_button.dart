import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton({
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
}) : super (
    child: Text(text,style: TextStyle(color: textColor),),
    backgroundColor: color,
    borderRadius: 4.0,
    onPressed: onPressed
  );
}