import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app/core/models/index.dart';
import 'package:flutter_app/core/common/index.dart';
import 'package:flutter_app/core/services/index.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isUserNameValid = false;

  AuthBloc() : super(AuthEmptyState());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStartedEvent) {
      yield* _navigateToStartedPage();
    } else if (event is EmailChangedEvent) {
      yield* _validateEmail(event);
    } else if (event is PasswordChangedEvent) {
      yield* _validatePassword(event);
    } else if (event is UserNameChangedEvent) {
      yield* _validateUserName(event);
    } else if (event is LoginPressedEvent) {
      yield* _login(event);
    } else if (event is SignupPressedEvent) {
      yield* _signup(event);
    } else if (event is ResetFormEvent) {
      yield* _resetForm();
    }
  }

  Stream<AuthState> _navigateToStartedPage() async* {
    final user = localStorageService.getString(LocalStorageKeys.user);
    if (user != '') {
      navigationService.navigateWithReplacementTo(Pages.home);
    } else {
      navigationService.navigateWithReplacementTo(
        Pages.initial,
        arguments: true,
      );
    }
  }

  Stream<AuthState> _validateEmail(EmailChangedEvent event) async* {
    _isEmailValid = Validators.isValidEmail(event.email);
    yield ValueChangedState();
  }

  Stream<AuthState> _validatePassword(PasswordChangedEvent event) async* {
    _isPasswordValid = Validators.isValidPassword(event.password);
    yield ValueChangedState();
  }

  Stream<AuthState> _validateUserName(UserNameChangedEvent event) async* {
    _isUserNameValid = Validators.isValidUserName(event.userName);
    yield ValueChangedState();
  }

  Stream<AuthState> _login(LoginPressedEvent event) async* {
    if (_isLoginFormValid) {
      final user = User(email: event.email, userName: '');

      localStorageService.putString(
          LocalStorageKeys.user, user.toJson().toString());

      navigationService.navigateTo(Pages.home);
    }
  }

  Stream<AuthState> _signup(SignupPressedEvent event) async* {
    if (_isSignupFormValid) {
      final user = User(email: event.email, userName: event.userName);

      localStorageService.putString(
          LocalStorageKeys.user, user.toJson().toString());

      navigationService.navigateTo(Pages.home);
    }
  }

  Stream<AuthState> _resetForm() async* {
    _isEmailValid = false;
    _isPasswordValid = false;
    _isUserNameValid = false;

    yield ValueChangedState();
  }

  bool get _isLoginFormValid => _isEmailValid && _isPasswordValid;
  bool get _isSignupFormValid =>
      _isEmailValid && _isPasswordValid && _isUserNameValid;

  bool get isEmailValid => _isEmailValid;
  bool get isPasswordValid => _isPasswordValid;
  bool get isUserNameValid => _isUserNameValid;
}
