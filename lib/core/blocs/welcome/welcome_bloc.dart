import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_app/core/services/index.dart';
import 'package:meta/meta.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeEmptyState());

  @override
  Stream<WelcomeState> mapEventToState(
    WelcomeEvent event,
  ) async* {
    if (event is TapOnLoginButtonEvent) {
      yield* _navigateToLoginPage();
    } else if (event is TapOnSignUpButtonEvent) {
      yield* _navigateToSignUpPage();
    }
  }

  Stream<WelcomeState> _navigateToLoginPage() async* {
    navigationService.navigateTo(Pages.login);
    yield WelcomeSuccessState();
  }

  Stream<WelcomeState> _navigateToSignUpPage() async* {
    navigationService.navigateTo(Pages.signUp);
    yield WelcomeSuccessState();
  }
}
