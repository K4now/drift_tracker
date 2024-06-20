part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadCarData extends ProfileEvent {
  final String userId;

  LoadCarData(this.userId);

  @override
  List<Object> get props => [userId];
}

class SaveCarDataEvent extends ProfileEvent {
  final String userId;
  final Car car;

  SaveCarDataEvent(this.userId, this.car);

  @override
  List<Object> get props => [userId, car];
}
