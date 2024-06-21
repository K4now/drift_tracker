part of 'measurement_bloc.dart';

abstract class MeasurementState extends Equatable {
  const MeasurementState();

  @override
  List<Object> get props => [];
}

class MeasurementInitial extends MeasurementState {}

class MeasurementDataUpdated extends MeasurementState {
  final double points;
  final double driftAngle;
  final double speed;
  final double maxAngle;

  MeasurementDataUpdated({
    required this.points,
    required this.driftAngle,
    required this.speed,
    required this.maxAngle,
  });

  @override
  List<Object> get props => [points, driftAngle, speed, maxAngle];
}

class SessionSaved extends MeasurementState {}

class SessionSaveError extends MeasurementState {}

// Новое состояние
class SessionSavedNotification extends MeasurementState {}
