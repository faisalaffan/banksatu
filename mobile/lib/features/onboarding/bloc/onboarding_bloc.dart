import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState.initial()) {
    on<CompleteOnboarding>(_onComplete);
  }

  void _onComplete(CompleteOnboarding event, Emitter<OnboardingState> emit) {
    emit(const OnboardingState.completed());
  }
}
