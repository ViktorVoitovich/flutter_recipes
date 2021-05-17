import 'package:flutter/material.dart';
import 'package:flutter_app/core/models/difficulty_level.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/generated/locale_keys.g.dart';

class RecipeItem extends StatelessWidget {
  final Recipe recipe;
  final Function onTap;
  final bool isSaved;
  final String heroTag;

  const RecipeItem({
    @required this.recipe,
    @required this.onTap,
    @required this.heroTag,
    this.isSaved = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 1.0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: [
            _buildRecipeImage(context),
            const SizedBox(width: 20.0),
            _buildRecipeInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeImage(BuildContext context) => Stack(
        children: [
          Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                recipe.image,
                width: 120.0,
                height: 120.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: -5.0,
            left: 80.0,
            child: Icon(
              Icons.bookmark,
              size: 30.0,
              color: isSaved ? Theme.of(context).primaryColor : Colors.white,
            ),
          ),
          Positioned(
            top: 80.0,
            left: 40.0,
            child: _buildHealthScoreLabel(),
          ),
        ],
      );

  Widget _buildHealthScoreLabel() => Container(
        width: 75.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.medical_services,
              size: 20.0,
              color: Colors.white,
            ),
            const SizedBox(width: 5.0),
            Text(
              recipe.healthScore.toStringAsFixed(1),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );

  Widget _buildRecipeInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 20.0,
            right: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRecipeTitle(),
              Row(
                children: [
                  _buildCookingTime(),
                  const SizedBox(width: 20.0),
                  _buildDifficulty(),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildRecipeTitle() => Wrap(
        children: [
          Text(
            recipe.title,
            style: const TextStyle(
              height: 1.2,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      );

  Widget _buildCookingTime() => Row(
        children: [
          const Icon(
            Icons.schedule,
            size: 25.0,
            color: Colors.green,
          ),
          const SizedBox(width: 5.0),
          Text(
            LocaleKeys.ready_in_minutes_info.tr(namedArgs: {
              'minutes': recipe.readyInMinutes.toString(),
            }),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );

  Widget _buildDifficulty() {
    final difficultyLevel = DifficultyLevel.fromReadyInMinutes(
      readyInMinutes: recipe.readyInMinutes,
    );

    return Row(
      children: [
        Icon(
          difficultyLevel.icon,
          size: 25.0,
          color: difficultyLevel.accentColor,
        ),
        const SizedBox(width: 5.0),
        Text(
          difficultyLevel.label.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
