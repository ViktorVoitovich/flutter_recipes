part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class SelectCategoryEvent extends CategoriesEvent {
  final int index;

  SelectCategoryEvent({@required this.index});
}
