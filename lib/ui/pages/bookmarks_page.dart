import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/ui/index.dart';
import 'package:flutter_app/core/blocs/index.dart';
import 'package:flutter_app/core/extensions/bloc_extension.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    context.bloc<BookmarksBloc>().add(FetchBookmarks());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(LocaleKeys.bookmarks_label).tr(),
          ),
          BlocBuilder<BookmarksBloc, BookmarksState>(
            builder: (context, bookmarksState) {
              if (bookmarksState is BookmarksLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (bookmarksState is BookmarksLoaded) {
                return _buildRecipiesList();
              } else if (bookmarksState is BookmarksError) {
                return _buildMessage(LocaleKeys.recipies_error);
              } else {
                return _buildMessage(LocaleKeys.empty_bookmarks);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecipiesList() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final recipe = context.bloc<BookmarksBloc>().recipes[index];
            final isSaved = context
                .bloc<BookmarksBloc>()
                .bookmarks
                .contains(recipe.id.toString());

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 7.0,
              ),
              child: RecipeItem(
                heroTag: '${recipe.id}_bookmark',
                isSaved: isSaved,
                recipe: recipe,
                onTap: () => context
                    .bloc<BookmarksBloc>()
                    .add(TapOnSavedRecipeEvent(recipe: recipe)),
              ),
            );
          },
          childCount: context.bloc<BookmarksBloc>().recipes.length,
        ),
      ),
    );
  }

  Widget _buildMessage(String message) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[350],
            ),
          ),
        ),
      ),
    );
  }
}
