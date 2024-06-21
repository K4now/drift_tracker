part of 'measurement_bloc.dart';

abstract class MeasurementEvent extends Equatable {
  const MeasurementEvent();

  @override
  List<Object> get props => [];
}

class StartListening extends MeasurementEvent {}

class StopListening extends MeasurementEvent {}

class SaveSession extends MeasurementEvent {}

class UpdateSensorData extends MeasurementEvent {
  final double points;
  final double driftAngle;
  final double speed;
  final double maxAngle;

  UpdateSensorData(this.points, this.driftAngle, this.speed, this.maxAngle);

  @override
  List<Object> get props => [points, driftAngle, speed, maxAngle];
}

class Calibrate extends MeasurementEvent {}

class Reset extends MeasurementEvent {} // Новое событие Reset
