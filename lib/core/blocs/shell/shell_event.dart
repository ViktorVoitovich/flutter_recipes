part of 'shell_bloc.dart';

@immutable
abstract class ShellEvent {}

class SelectBarItemEvent extends ShellEvent {
  final int index;

  SelectBarItemEvent({@required this.index});
}
