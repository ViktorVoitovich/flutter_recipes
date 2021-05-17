part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthEmptyState extends AuthState {}

class ValueChangedState extends AuthState {}
