import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {

  CustomElevatedButton({
    required this.child,
    this.borderRadius = 4.0,
    required this.onPressed,
    required this.backgroundColor,
    this.height= 40.0
});

  final Widget child;
  final double borderRadius;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      child: ElevatedButton (
        child: child,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
