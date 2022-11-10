import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton({
    required String assetName,
    required String text,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) :
        assert(assetName != null),
        assert(text != null),
        super (
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(assetName),
          Text(text,
              style: TextStyle(fontSize: 14, color: textColor),
              textAlign: TextAlign.center),
          Opacity(
              opacity: 0.0,
              child: Image.asset(assetName)),
        ],
      ),
      backgroundColor: color,
      borderRadius: 4.0,
      onPressed: onPressed
  );
}