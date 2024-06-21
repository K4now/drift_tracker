import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../../domain/usecases/save_session.dart';

part 'measurement_event.dart';
part 'measurement_state.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final SaveSessionUseCase saveSessionUseCase;

  late StreamSubscription _gyroscopeSubscription;
  late StreamSubscription<Position> _positionSubscription;

  double _points = 0.0;
  double _driftAngle = 0.0;
  double _speed = 0.0;
  double _lastGyroTime = 0.0;
  double _maxAngle = 0.0;

  MeasurementBloc(this.saveSessionUseCase) : super(MeasurementInitial()) {
    on<StartListening>(_onStartListening);
    on<StopListening>(_onStopListening);
    on<SaveSession>(_onSaveSession);
    on<UpdateSensorData>(_onUpdateSensorData);
    on<Calibrate>(_onCalibrate);
    on<Reset>(_onReset); // Добавляем обработчик для события Reset
  }

  Future<void> _onStartListening(
      StartListening event, Emitter<MeasurementState> emit) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      final double now = DateTime.now().millisecondsSinceEpoch.toDouble();
      final double deltaTime = (now - _lastGyroTime) / 1000.0;
      _lastGyroTime = now;

      _calculateDriftAngle(event.z, deltaTime);
      _calculatePoints(event.z, deltaTime);

      add(UpdateSensorData(_points, _driftAngle, _speed, _maxAngle));
    });

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _speed = position.speed;
      add(UpdateSensorData(_points, _driftAngle, _speed, _maxAngle));
    });
  }

  void _calculateDriftAngle(double gyroZ, double deltaTime) {
    double previousAngle = _driftAngle;
    _driftAngle += gyroZ * deltaTime;
    if (_driftAngle > 180) {
      _driftAngle -= 360;
    } else if (_driftAngle < -180) {
      _driftAngle += 360;
    }
    if (_driftAngle.abs() > _maxAngle) {
      _maxAngle = _driftAngle.abs();
    }

    if ((previousAngle >= 0 && _driftAngle < 0) ||
        (previousAngle < 0 && _driftAngle >= 0)) {
      double transitionSharpness = (gyroZ / deltaTime).abs();
      _points += transitionSharpness * 50;
    }
  }

  void _calculatePoints(double gyroZ, double deltaTime) {
    double speedKmh = _speed * 3.6;
    double angleChangeRate = gyroZ.abs() / deltaTime;

    if (angleChangeRate.isFinite && speedKmh.isFinite && _driftAngle.isFinite) {
      _points += (speedKmh / 10) * _driftAngle.abs() * angleChangeRate;
      _points = _points < 0 ? 0 : _points;
    }
  }

  Future<void> _onSaveSession(
      SaveSession event, Emitter<MeasurementState> emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final session = Session(
        id: UniqueKey().toString(),
        userId: user.uid,
        maxAngle: _maxAngle,
        points: _points.isFinite ? _points.toInt() : 0,
        averageSpeed: _speed.isFinite ? _speed * 3.6 : 0.0,
        timestamp: Timestamp.now(),
      );
      try {
        await saveSessionUseCase(session);
        emit(SessionSavedNotification()); // Эмитируем новое состояние
      } catch (error) {
        emit(SessionSaveError());
      }
    } else {
      emit(SessionSaveError());
    }
  }

  void _onStopListening(StopListening event, Emitter<MeasurementState> emit) {
    _gyroscopeSubscription.cancel();
    _positionSubscription.cancel();
  }

  void _onUpdateSensorData(
      UpdateSensorData event, Emitter<MeasurementState> emit) {
    emit(MeasurementDataUpdated(
      points: event.points,
      driftAngle: event.driftAngle,
      speed: event.speed,
      maxAngle: event.maxAngle,
    ));
  }

  void _onCalibrate(Calibrate event, Emitter<MeasurementState> emit) {
    _points = 0.0;
    _driftAngle = 0.0;
    _maxAngle = 0.0;
    _lastGyroTime = DateTime.now().millisecondsSinceEpoch.toDouble();
    emit(MeasurementDataUpdated(
      points: _points,
      driftAngle: _driftAngle,
      speed: _speed,
      maxAngle: _maxAngle,
    ));
  }

  // Метод для обработки события Reset
  void _onReset(Reset event, Emitter<MeasurementState> emit) {
    _points = 0.0;
    _driftAngle = 0.0;
    _speed = 0.0;
    _lastGyroTime = 0.0;
    _maxAngle = 0.0;
    emit(MeasurementDataUpdated(
      points: _points,
      driftAngle: _driftAngle,
      speed: _speed,
      maxAngle: _maxAngle,
    ));
  }
}
