import 'package:flutter/material.dart';

import 'package:flutter_app/core/common/index.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;

  const BackgroundImage({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(Assets.backgroundImage),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2),
                BlendMode.darken,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
