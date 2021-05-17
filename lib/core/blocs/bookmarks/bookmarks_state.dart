part of 'bookmarks_bloc.dart';

@immutable
abstract class BookmarksState {}

class BookmarksInitial extends BookmarksState {}

class BookmarksEmpty extends BookmarksState {}

class BookmarksUpdated extends BookmarksState {}

class BookmarksLoading extends BookmarksState {}

class BookmarksLoaded extends BookmarksState {}

class BookmarksError extends BookmarksState {}
