part of 'shell_bloc.dart';

@immutable
abstract class ShellState {}

class ShellEmptyState extends ShellState {}

class ShellSuccessState extends ShellState {}
