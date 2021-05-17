import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/ui/utils/index.dart';
import 'package:flutter_app/ui/index.dart';
import 'package:flutter_app/core/common/assets.dart';
import 'package:flutter_app/core/blocs/index.dart';
import 'package:flutter_app/generated/locale_keys.g.dart';
import 'package:flutter_app/core/extensions/index.dart';

const paginationOffset = 5;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  int _currentOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final pixels = _scrollController.position.pixels;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final recipes = context.bloc<RecipesBloc>().recipes;
      final categories = context.bloc<CategoriesBloc>().allCategories;
      final currentCategoryIndex = context.bloc<CategoriesBloc>().selectedIndex;

      if (pixels == maxScrollExtent && recipes.isNotEmpty) {
        _currentOffset += paginationOffset;
        context.bloc<RecipesBloc>().add(FetchRecipesBasedOnOffsetEvent(
              offset: _currentOffset,
              category: categories[currentCategoryIndex],
            ));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BlocBuilder<BookmarksBloc, BookmarksState>(
            builder: (context, bookmarksState) {
              if (bookmarksState is BookmarksInitial) {
                return _buildSpinner();
              }
              return CustomScrollView(
                controller: _scrollController,
                slivers: [
                  _buildHeader(),
                  ..._buildPopularRecipesSection(),
                ],
              );
            },
          ),
          BlocBuilder<RecipesBloc, RecipesState>(builder: (_, recipeState) {
            if (recipeState is MoreRecipesLoading) {
              return _buildSpinner();
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildSpinner() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: LinearProgressIndicator(),
    );
  }

  Widget _buildHeader() {
    return SliverPersistentHeader(
      floating: true,
      delegate: PersistentHeaderDelegate(
        minHeight: 350.0,
        maxHeight: 350.0,
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              _buildProfileInfo(),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0),
                width: 250.0,
                child: const Text(
                  LocaleKeys.search_title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    height: 1.5,
                  ),
                ).tr(),
              ),
              const SizedBox(height: 10.0),
              _buildSearchInput(),
              const SizedBox(height: 20.0),
              _buildCategory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory() {
    final categories = context.bloc<CategoriesBloc>().allCategories;

    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, categoriesState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: const Text(
                LocaleKeys.category,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ).tr(),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (_, index) {
                  return _buildChip(
                    label: categories[index],
                    isSelected:
                        context.bloc<CategoriesBloc>().selectedIndex == index,
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildChip({String label, bool isSelected, int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: GestureDetector(
        onTap: () {
          context.bloc<CategoriesBloc>().add(SelectCategoryEvent(index: index));
          context.bloc<RecipesBloc>().add(
                FetchRecipesBasedOnCategoryEvent(
                  category: context.bloc<CategoriesBloc>().allCategories[index],
                ),
              );
        },
        child: Chip(
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          backgroundColor: isSelected ? Colors.red : Colors.red[100],
          label: Text(label),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              image: const DecorationImage(
                image: AssetImage(Assets.defaultAvatar),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          const Text(
            LocaleKeys.welcome_message,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ).tr(namedArgs: {'name': 'Viktor'}),
        ],
      ),
    );
  }

  Widget _buildSearchInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        onSubmitted: (value) {
          print(value);
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20.0),
            prefixIcon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            hintText: LocaleKeys.search_label.tr(),
            filled: true,
            fillColor: Colors.grey[200],
            focusColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.transparent,
              ),
            )),
      ),
    );
  }

  List<Widget> _buildPopularRecipesSection() {
    return [
      _buildRecipiesTitle(),
      BlocBuilder<RecipesBloc, RecipesState>(
        builder: (context, recipesState) {
          if (recipesState is RecipesInitial) {
            context.bloc<RecipesBloc>().add(FetchRecipesEvent());
          } else if (recipesState is RecipesError) {
            return _buildErrorMessage();
          } else if (recipesState is RecipesLoading) {
            return const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return _buildRecipiesList();
        },
      ),
    ];
  }

  Widget _buildRecipiesTitle() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeaderDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          color: Colors.grey[50],
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 15.0,
            ),
            child: const Text(
              'popular_recipe',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            LocaleKeys.recipies_error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey[350],
            ),
          ).tr(),
        ),
      ),
    );
  }

  Widget _buildRecipiesList() {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 20.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final recipe = context.bloc<RecipesBloc>().recipes[index];
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
                heroTag: '${recipe.id}_recipe',
                isSaved: isSaved,
                recipe: recipe,
                onTap: () => context
                    .bloc<RecipesBloc>()
                    .add(TapOnRecipeEvent(recipe: recipe)),
              ),
            );
          },
          childCount: context.bloc<RecipesBloc>().recipes.length,
        ),
      ),
    );
  }
}
