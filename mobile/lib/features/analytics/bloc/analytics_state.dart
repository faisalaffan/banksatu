part of 'analytics_bloc.dart';

@immutable
sealed class AnalyticsState {
  const AnalyticsState();
}

class AnalyticsInitial extends AnalyticsState {
  const AnalyticsInitial();
}

class AnalyticsLoaded extends AnalyticsState {
  const AnalyticsLoaded();
}
