import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/core/common/index.dart';
import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/core/services/index.dart';

part 'bookmarks_event.dart';
part 'bookmarks_state.dart';

class BookmarksBloc extends Bloc<BookmarksEvent, BookmarksState> {
  List<String> _bookmarks = [];
  List<Recipe> _recipes = [];

  BookmarksBloc() : super(BookmarksInitial());

  @override
  Stream<BookmarksState> mapEventToState(
    BookmarksEvent event,
  ) async* {
    if (event is LoadBookmarks) {
      yield* _loadBookmarks();
    } else if (event is TapOnBookmark) {
      yield* _updateBookmarks(event.id);
    } else if (event is FetchBookmarks) {
      yield* _fetchBookmarks();
    } else if (event is TapOnSavedRecipeEvent) {
      _navigateToRecipeDetails(event.recipe);
    }
  }

  Stream<BookmarksState> _fetchBookmarks() async* {
    yield BookmarksLoading();

    try {
      if (_bookmarks.isEmpty) {
        yield BookmarksEmpty();
      } else {
        _recipes = await recipesService.getRecipiesByIds(ids: _bookmarks);
        yield BookmarksLoaded();
      }
    } catch (_) {
      yield BookmarksError();
    }
  }

  Stream<BookmarksState> _loadBookmarks() async* {
    final bookmarks = localStorageService.getStringList(
      LocalStorageKeys.bookmarks,
    );

    if (bookmarks.isNotEmpty) {
      _bookmarks.addAll(bookmarks);
    }

    yield BookmarksUpdated();
  }

  Stream<BookmarksState> _updateBookmarks(int id) async* {
    _bookmarks = localStorageService.getStringList(
      LocalStorageKeys.bookmarks,
    );

    if (_bookmarks.contains(id.toString())) {
      _bookmarks.remove(id.toString());
    } else {
      _bookmarks.add(id.toString());
    }

    localStorageService.putStringList(LocalStorageKeys.bookmarks, _bookmarks);

    yield BookmarksUpdated();
  }

  void _navigateToRecipeDetails(Recipe recipe) {
    navigationService.navigateTo(Pages.recipeDetails, arguments: recipe);
  }

  List<String> get bookmarks => _bookmarks;
  List<Recipe> get recipes => _recipes;
}
