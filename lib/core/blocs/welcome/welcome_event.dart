part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

class TapOnLoginButtonEvent extends WelcomeEvent {}

class TapOnSignUpButtonEvent extends WelcomeEvent {}
