import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shell_event.dart';
part 'shell_state.dart';

class ShellBloc extends Bloc<ShellEvent, ShellState> {
  int _selectedIndex = 0;

  ShellBloc() : super(ShellEmptyState());

  @override
  Stream<ShellState> mapEventToState(
    ShellEvent event,
  ) async* {
    if (event is SelectBarItemEvent) {
      yield* _selectBarItem(event.index);
    }
  }

  Stream<ShellState> _selectBarItem(int index) async* {
    _selectedIndex = index;
    yield ShellSuccessState();
  }

  int get selectedIndex => _selectedIndex;
}
