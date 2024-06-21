import 'package:drift_tracker/domain/entities/user_measurement.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

abstract class UserMeasurementRepository {
  Stream<UserMeasurement> getUserMeasurements();
  Future<void> saveSession(UserMeasurement session);
}


