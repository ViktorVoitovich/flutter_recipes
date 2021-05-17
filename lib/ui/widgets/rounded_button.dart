import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color textColor;
  final Color backgroundColor;

  const RoundedButton({
    @required this.title,
    @required this.onPressed,
    this.width,
    this.height,
    this.textColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
