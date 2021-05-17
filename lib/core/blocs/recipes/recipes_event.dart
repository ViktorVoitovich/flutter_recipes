part of 'recipes_bloc.dart';

@immutable
abstract class RecipesEvent {}

class FetchRecipesEvent extends RecipesEvent {}

class TapOnRecipeEvent extends RecipesEvent {
  final Recipe recipe;

  TapOnRecipeEvent({@required this.recipe});
}

class FetchRecipesBasedOnCategoryEvent extends RecipesEvent {
  final String category;

  FetchRecipesBasedOnCategoryEvent({@required this.category});
}

class FetchRecipesBasedOnOffsetEvent extends RecipesEvent {
  final int offset;
  final String category;

  FetchRecipesBasedOnOffsetEvent({
    @required this.offset,
    this.category,
  });
}
