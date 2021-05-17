part of 'recipe_details_bloc.dart';

@immutable
abstract class RecipeDetailsEvent {}

class GoBackEvent extends RecipeDetailsEvent {}

class StepCancelEvent extends RecipeDetailsEvent {}

class StepContinueEvent extends RecipeDetailsEvent {
  final int stepsLength;

  StepContinueEvent({@required this.stepsLength});
}

class StepTappedEvent extends RecipeDetailsEvent {
  final int index;

  StepTappedEvent({@required this.index});
}
