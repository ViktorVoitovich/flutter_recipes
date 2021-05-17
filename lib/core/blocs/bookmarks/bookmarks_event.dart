part of 'bookmarks_bloc.dart';

@immutable
abstract class BookmarksEvent {}

class FetchBookmarks extends BookmarksEvent {}

class LoadBookmarks extends BookmarksEvent {}

class TapOnBookmark extends BookmarksEvent {
  final int id;

  TapOnBookmark({@required this.id});
}

class TapOnSavedRecipeEvent extends BookmarksEvent {
  final Recipe recipe;

  TapOnSavedRecipeEvent({@required this.recipe});
}
