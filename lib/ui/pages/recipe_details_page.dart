import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_app/ui/widgets/index.dart';
import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/core/blocs/index.dart';
import 'package:flutter_app/core/extensions/index.dart';
import 'package:url_launcher/url_launcher.dart';

const slidingUpPanelMinHeightOffset = 350.0;
const slidingUpPanelMaxHeightOffset = 150.0;

class RecipeDetailsPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailsPage({@required this.recipe});

  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarksBloc, BookmarksState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: _buildAppBar(),
          body: SlidingUpPanel(
            boxShadow: const [],
            backdropEnabled: true,
            parallaxEnabled: true,
            minHeight: MediaQuery.of(context).size.height -
                slidingUpPanelMinHeightOffset,
            maxHeight: MediaQuery.of(context).size.height -
                slidingUpPanelMaxHeightOffset,
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                _buildRecipeImage(),
              ],
            ),
            panelBuilder: _buildPanel,
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    final isRecipeInBookmarks = context
        .bloc<BookmarksBloc>()
        .bookmarks
        .contains(widget.recipe.id.toString());

    return AppBar(
      actions: [
        _buildAppBarButton(
          icon: Icon(
            Icons.bookmark,
            color: isRecipeInBookmarks
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
          margin: const EdgeInsets.only(right: 10.0),
          onPressed: () {
            context
                .bloc<BookmarksBloc>()
                .add(TapOnBookmark(id: widget.recipe.id));
          },
        ),
      ],
      leading: _buildAppBarButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          margin: const EdgeInsets.only(left: 10.0),
          onPressed: () =>
              context.bloc<RecipeDetailsBloc>().add(GoBackEvent())),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildAppBarButton({
    Icon icon,
    Function onPressed,
    EdgeInsets margin,
  }) {
    return Container(
      margin: margin,
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRecipeImage() {
    return Hero(
      tag: widget.recipe.id,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
        ),
        child: Image.network(
          widget.recipe.image,
          height: 350.0,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPanel(ScrollController sc) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      controller: sc,
      children: [
        const SizedBox(height: 30.0),
        Text(
          widget.recipe.title,
          style: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),
        _buildRecipeInfo(),
        const SizedBox(height: 20.0),
        ..._buildDescription(),
        if (widget.recipe.analyzedInstructions.isNotEmpty)
          ..._buildDirections(),
      ],
    );
  }

  Widget _buildRecipeInfo() {
    final difficultyLevel = DifficultyLevel.fromReadyInMinutes(
      readyInMinutes: widget.recipe.readyInMinutes,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoIcon(
          icon: Icons.schedule,
          mainColor: Colors.green[100],
          accentColor: Colors.green[300],
          lable: LocaleKeys.ready_in_minutes_info.tr(
            namedArgs: {'minutes': widget.recipe.readyInMinutes.toString()},
          ),
        ),
        _buildInfoIcon(
          icon: difficultyLevel.icon,
          mainColor: difficultyLevel.mainColor,
          accentColor: difficultyLevel.accentColor,
          lable: difficultyLevel.label,
        ),
        _buildInfoIcon(
          icon: Icons.local_fire_department,
          mainColor: Colors.blue[100],
          accentColor: Colors.blue[300],
          lable: LocaleKeys.servings_info.tr(
            namedArgs: {'servings': widget.recipe.servings.toString()},
          ),
        ),
      ],
    );
  }

  Widget _buildInfoIcon({
    Color mainColor,
    Color accentColor,
    IconData icon,
    String lable,
  }) {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50.0,
            color: accentColor,
          ),
          Text(
            lable,
            style: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDescription() {
    return [
      Text(
        LocaleKeys.description.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: 10.0),
      Html(
        onLinkTap: (url) async {
          await canLaunch(url)
              ? await launch(url)
              : throw Exception('Could not launch url:$url');
        },
        data: widget.recipe.summary,
      ),
      const SizedBox(height: 20.0),
    ];
  }

  List<Widget> _buildDirections() {
    final steps = widget.recipe.analyzedInstructions[0].steps;

    return [
      Text(
        LocaleKeys.steps.tr(),
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      BlocBuilder<RecipeDetailsBloc, RecipeDetailsState>(
        builder: (_, __) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: Stepper(
              physics: const NeverScrollableScrollPhysics(),
              controlsBuilder: (_, {onStepCancel, onStepContinue}) {
                return _buildCustomStepperControls(
                  stepsLength: steps.length,
                  onStepCancel: onStepCancel,
                  onStepContinue: onStepContinue,
                );
              },
              currentStep: context.bloc<RecipeDetailsBloc>().currentStepIndex,
              onStepCancel: () {
                context.bloc<RecipeDetailsBloc>().add(StepCancelEvent());
              },
              onStepContinue: () {
                context
                    .bloc<RecipeDetailsBloc>()
                    .add(StepContinueEvent(stepsLength: steps.length));
              },
              onStepTapped: (index) {
                context
                    .bloc<RecipeDetailsBloc>()
                    .add(StepTappedEvent(index: index));
              },
              steps: List.generate(
                steps.length,
                (index) {
                  final step = steps[index];
                  return Step(
                    title: const Text(
                      LocaleKeys.step_title,
                    ).tr(namedArgs: {'number': step.number.toString()}),
                    content: Text(
                      step.step,
                      style: const TextStyle(
                        fontSize: 16.0,
                        height: 1.5,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildCustomStepperControls({
    Function onStepContinue,
    Function onStepCancel,
    int stepsLength,
  }) {
    final currentStepIndex = context.bloc<RecipeDetailsBloc>().currentStepIndex;
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          if (currentStepIndex != stepsLength - 1)
            RoundedButton(
              title: LocaleKeys.continue_lable.tr(),
              onPressed: onStepContinue,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            ),
          const SizedBox(width: 10.0),
          if (currentStepIndex != 0)
            RoundedButton(
              title: LocaleKeys.cancel_label.tr(),
              onPressed: onStepCancel,
              backgroundColor: Colors.grey[200],
              textColor: Colors.black,
            ),
        ],
      ),
    );
  }
}
