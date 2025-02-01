part of '../app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.started() = _Started;
  const factory AppEvent.increment() = _Increment;
  const factory AppEvent.decrement() = _Decrement;
}
