import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_app/core/services/index.dart';

part 'recipe_details_event.dart';
part 'recipe_details_state.dart';

class RecipeDetailsBloc extends Bloc<RecipeDetailsEvent, RecipeDetailsState> {
  int _currentStepIndex = 0;

  RecipeDetailsBloc() : super(RecipeDetailsInitial());

  @override
  Stream<RecipeDetailsState> mapEventToState(
    RecipeDetailsEvent event,
  ) async* {
    if (event is GoBackEvent) {
      navigationService.goBack();
    } else if (event is StepTappedEvent) {
      yield* _changeCurrentStep(event.index);
    } else if (event is StepContinueEvent) {
      yield* _moveToNextStep(event.stepsLength);
    } else if (event is StepCancelEvent) {
      yield* _moveToPreviousStep();
    }
  }

  Stream<RecipeDetailsState> _changeCurrentStep(int index) async* {
    _currentStepIndex = index;
    yield StepperIndexChanged();
  }

  Stream<RecipeDetailsState> _moveToNextStep(int stepsLength) async* {
    if (_currentStepIndex <= stepsLength - 1) {
      _currentStepIndex += 1;
      yield StepperIndexChanged();
    }
  }

  Stream<RecipeDetailsState> _moveToPreviousStep() async* {
    if (_currentStepIndex >= 0) {
      _currentStepIndex -= 1;
      yield StepperIndexChanged();
    }
  }

  int get currentStepIndex => _currentStepIndex;
}
