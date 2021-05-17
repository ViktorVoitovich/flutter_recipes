part of 'recipes_bloc.dart';

@immutable
abstract class RecipesState {}

class RecipesInitial extends RecipesState {}

class RecipesLoading extends RecipesState {}

class RecipesLoaded extends RecipesState {}

class MoreRecipesLoading extends RecipesState {}

class MoreRecipesLoaded extends RecipesState {}

class RecipesError extends RecipesState {}
