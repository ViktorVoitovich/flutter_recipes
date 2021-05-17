import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/core/services/index.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  List<Recipe> _recipes = [];

  RecipesBloc() : super(RecipesInitial());

  @override
  Stream<RecipesState> mapEventToState(
    RecipesEvent event,
  ) async* {
    if (event is FetchRecipesEvent) {
      yield* _fetchRecipes();
    } else if (event is TapOnRecipeEvent) {
      _navigateToRecipeDetails(event.recipe);
    } else if (event is FetchRecipesBasedOnCategoryEvent) {
      yield* _fetchRecipesBasedOnCategory(event.category);
    } else if (event is FetchRecipesBasedOnOffsetEvent) {
      yield* _fetchRecipesBasedOnOffset(
        offset: event.offset,
        category: event.category,
      );
    }
  }

  Stream<RecipesState> _fetchRecipes() async* {
    yield RecipesLoading();

    try {
      final newRecipes = await recipesService.getRecipies();
      _recipes.addAll(newRecipes);
      yield RecipesLoaded();
    } catch (_) {
      yield RecipesError();
    }
  }

  Stream<RecipesState> _fetchRecipesBasedOnCategory(String category) async* {
    yield RecipesLoading();

    try {
      _recipes = await recipesService.getRecipies(category: category);
      yield RecipesLoaded();
    } catch (_) {
      yield RecipesError();
    }
  }

  Stream<RecipesState> _fetchRecipesBasedOnOffset({
    int offset,
    String category,
  }) async* {
    yield MoreRecipesLoading();

    try {
      final newRecipes = await recipesService.getRecipies(
        offset: offset,
        category: category,
      );
      _recipes.addAll(newRecipes);
      yield MoreRecipesLoaded();
    } catch (_) {
      yield RecipesError();
    }
  }

  void _navigateToRecipeDetails(Recipe recipe) {
    navigationService.navigateTo(Pages.recipeDetails, arguments: recipe);
  }

  List<Recipe> get recipes => _recipes;
}
