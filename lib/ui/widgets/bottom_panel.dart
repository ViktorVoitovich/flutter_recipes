import 'package:flutter/material.dart';

class BottomPanel extends StatelessWidget {
  final Widget child;

  const BottomPanel({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 450.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: child,
      ),
    );
  }
}
