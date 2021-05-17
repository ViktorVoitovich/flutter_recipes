import 'package:flutter/material.dart';

import 'index.dart';

class FormWithButton extends StatelessWidget {
  final List<Widget> children;
  final String buttonTitle;
  final Function onPressed;

  const FormWithButton({
    @required this.buttonTitle,
    @required this.onPressed,
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ...children,
          Builder(
            builder: (_) => RoundedButton(
              title: buttonTitle.toUpperCase(),
              onPressed: onPressed,
              textColor: Colors.white,
              backgroundColor: Colors.red,
              width: 250.0,
              height: 60.0,
            ),
          ),
        ],
      ),
    );
  }
}
