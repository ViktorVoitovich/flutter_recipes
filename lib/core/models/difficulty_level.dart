import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_app/generated/locale_keys.g.dart';

class DifficultyLevel {
  final IconData icon;
  final String label;
  final Color accentColor;
  final Color mainColor;

  DifficultyLevel({
    @required this.icon,
    @required this.label,
    @required this.accentColor,
    @required this.mainColor,
  });

  factory DifficultyLevel.fromReadyInMinutes({@required readyInMinutes}) {
    if (readyInMinutes <= 20) {
      return DifficultyLevel(
          icon: Icons.mood,
          label: LocaleKeys.eazy.tr(),
          mainColor: Colors.green[100],
          accentColor: Colors.green[300]);
    } else if (readyInMinutes <= 60) {
      return DifficultyLevel(
          icon: Icons.sentiment_satisfied,
          label: LocaleKeys.normal.tr(),
          mainColor: Colors.yellow[300],
          accentColor: Colors.yellow[700]);
    } else {
      return DifficultyLevel(
          icon: Icons.mood_bad,
          label: LocaleKeys.difficult.tr(),
          mainColor: Colors.red[300],
          accentColor: Colors.red);
    }
  }
}
