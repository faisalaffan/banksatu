part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {
  const OnboardingState();
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted();
}
