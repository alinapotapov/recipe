import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event/app_event.dart';
part 'state/app_state.dart';
part 'app_bloc.freezed.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.initial()) {
    on<_Started>((event, emit) {
      emit(const AppState.initial());
    });

    on<_Increment>((event, emit) {
      //TODO
    });

    on<_Decrement>((event, emit) {
      //TODO
    });
  }
}
