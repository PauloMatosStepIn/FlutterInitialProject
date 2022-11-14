import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton {

  FormSubmitButton({
    required String text,
    required VoidCallback onPressed,
  }) : super(
      child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20)
      ),
          height: 44,
    borderRadius: 4,
    onPressed: onPressed,
    backgroundColor: Colors.indigo
  );
}