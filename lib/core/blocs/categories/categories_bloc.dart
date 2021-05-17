import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final List<String> _categories = [
    'All',
    'Meat',
    'Fish',
    'Noodles',
    'Salad',
    'Seafood',
    'Bakery',
    'Smoothies'
  ];
  int _currentCategoryIndex = 0;

  CategoriesBloc() : super(CategoriesInitial());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is SelectCategoryEvent) {
      yield* _changeCurrentCategory(event.index);
    }
  }

  Stream<CategoriesState> _changeCurrentCategory(int index) async* {
    _currentCategoryIndex = index;
    yield CategoriesUpdated();
  }

  int get selectedIndex => _currentCategoryIndex;
  List<String> get allCategories => [..._categories];
}
