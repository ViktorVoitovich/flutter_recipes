part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AppStartedEvent extends AuthEvent {}

class EmailChangedEvent extends AuthEvent {
  final String email;

  EmailChangedEvent({@required this.email});
}

class PasswordChangedEvent extends AuthEvent {
  final String password;

  PasswordChangedEvent({@required this.password});
}

class UserNameChangedEvent extends AuthEvent {
  final String userName;

  UserNameChangedEvent({@required this.userName});
}

class LoginPressedEvent extends AuthEvent {
  final String email;
  final String password;

  LoginPressedEvent({
    @required this.email,
    @required this.password,
  });
}

class SignupPressedEvent extends AuthEvent {
  final String email;
  final String password;
  final String userName;

  SignupPressedEvent({
    @required this.email,
    @required this.password,
    @required this.userName,
  });
}

class ResetFormEvent extends AuthEvent {}
