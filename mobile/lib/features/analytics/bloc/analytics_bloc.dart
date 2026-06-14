import 'package:flutter_bloc/flutter_bloc.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc() : super(const AnalyticsState.initial()) {
    on<LoadAnalytics>(_onLoad);
  }

  void _onLoad(LoadAnalytics event, Emitter<AnalyticsState> emit) {
    emit(const AnalyticsState.loaded());
  }
}
