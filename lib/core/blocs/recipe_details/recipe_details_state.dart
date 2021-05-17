part of 'recipe_details_bloc.dart';

@immutable
abstract class RecipeDetailsState {}

class RecipeDetailsInitial extends RecipeDetailsState {}

class StepperIndexChanged extends RecipeDetailsState {}
