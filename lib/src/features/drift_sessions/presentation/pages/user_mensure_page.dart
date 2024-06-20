import '../../../../../generated/l10n.dart';
import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/angle_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';

@RoutePage()
class UserMeasurementPage extends StatefulWidget {
  @override
  _UserMeasurementPageState createState() => _UserMeasurementPageState();
}

class _UserMeasurementPageState extends State<UserMeasurementPage> {
  double _points = 0.0;
  double _driftAngle = 0.0;
  double _speed = 0.0; // Скорость в м/с
  double _lastGyroTime = 0.0;
  double _angle = 0.0;
  double _maxAngle = 0.0;
// Штраф за резкие изменения угла

  late StreamSubscription _gyroscopeSubscription;
  late StreamSubscription<Position> _positionSubscription;
  Timer? _testTimer;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() async {
    // Запрашиваем разрешения на доступ к местоположению
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Сервис местоположения отключен, запросите пользователя включить его.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Разрешение отклонено
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Разрешения навсегда отклонены, вы не можете запросить разрешения.
      return;
    }

    _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
      final double now = DateTime.now().millisecondsSinceEpoch.toDouble();
      final double deltaTime = (now - _lastGyroTime) / 1000.0;
      _lastGyroTime = now;

      setState(() {
        _calculateDriftAngle(event.z, deltaTime);
        _calculatePoints(event.z, deltaTime);
      });
    });

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Минимальное расстояние в метрах для обновления
      ),
    ).listen((Position position) {
      setState(() {
        _speed = position.speed; // Скорость в м/с
      });
    });
  }

  void _calculateDriftAngle(double gyroZ, double deltaTime) {
    double previousAngle = _driftAngle;
    setState(() {
      _driftAngle += gyroZ * deltaTime;
      // Приведение угла к диапазону от -180 до 180 градусов
      if (_driftAngle > 180) {
        _driftAngle -= 360;
      } else if (_driftAngle < -180) {
        _driftAngle += 360;
      }
      if (_driftAngle.abs() > _maxAngle) {
        _maxAngle = _driftAngle.abs();
      }

      // Проверка на перекладку (смену направления дрифта) и резкость перекладки
      if ((previousAngle >= 0 && _driftAngle < 0) ||
          (previousAngle < 0 && _driftAngle >= 0)) {
        double transitionSharpness = (gyroZ / deltaTime).abs();
        _points += transitionSharpness * 50; // Дополнительные очки за резкость перекладки
      }

      // Рассчитываем текущий угол
      _calculateAngle();
    });
  }

  void _calculateAngle() {
    setState(() {
      _angle = _driftAngle;
    });
  }

  void _calculatePoints(double gyroZ, double deltaTime) {
    double speedKmh = _speed * 3.6;
    double angleChangeRate = gyroZ.abs() / deltaTime; // Резкость изменения угла

    setState(() {
      // Формула расчета очков с учетом скорости, угла, резкости изменения угла и штрафа за резкость
      _points += (speedKmh / 10) * _driftAngle.abs() * angleChangeRate;

      // Убираем возможность уменьшения очков
      _points = _points < 0 ? 0 : _points;
    });
  }

  void _calibrate() {
    setState(() {
      _driftAngle = 0.0;
      _points = 0.0; // Сбрасываем очки при калибровке
      _maxAngle = 0.0; // Сбрасываем максимальный угол при калибровке
// Сбрасываем штраф при калибровке
    });
  }

  Future<void> _saveSession() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final session = Session(
        id: UniqueKey().toString(),
        userId: user.uid,
        maxAngle: _maxAngle,
        points: _points.toInt(),
        averageSpeed: _speed * 3.6, // Средняя скорость в км/ч
        timestamp: Timestamp.now(),
      );
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(session.id)
          .set(session.toMap());
      _showMessage(S.of(context).carDataSaved);
    } else {
      _showError(S.of(context).fieldRequired);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message, style: TextStyle(color: Colors.red))));
  }

  void _stopListening() {
    _gyroscopeSubscription.cancel();
    _positionSubscription.cancel();
    _testTimer?.cancel();
  }





  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double speedKmh = _speed * 3.6; // Конвертация скорости в км/ч

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).session),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      '${S.of(context).points}: ${_points.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${S.of(context).currentVelocity}: ${speedKmh.toStringAsFixed(2)} km/h',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${S.of(context).currentAngle}: ${_angle.toStringAsFixed(2)}°',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '${S.of(context).maxAngle}: ${_maxAngle.toStringAsFixed(2)}°',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _calibrate,
                  icon: Icon(Icons.settings_backup_restore),
                  label: Text(S.of(context).calibrate),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _saveSession,
                  icon: Icon(Icons.save),
                  label: Text(S.of(context).saveSession),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
                SizedBox(height: 160,),
                  AngleIndicator(angle: _angle),
                // ElevatedButton.icon(
                //   onPressed: _startTest,
                //   icon: Icon(Icons.play_arrow),
                //   label: Text(S.of(context).startTest),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () => _simulateSpeedChange(1.0),
                //   icon: Icon(Icons.add),
                //   label: Text(S.of(context).increaseSpeed),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () => _simulateSpeedChange(-1.0),
                //   icon: Icon(Icons.remove),
                //   label: Text(S.of(context).decreaseSpeed),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () => _simulateAngleChange(10.0),
                //   icon: Icon(Icons.add),
                //   label: Text(S.of(context).increaseAngle),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: () => _simulateAngleChange(-10.0),
                //   icon: Icon(Icons.remove),
                //   label: Text(S.of(context).decreaseAngle),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                // ),
                // ElevatedButton.icon(
                //   onPressed: _simulateTransition,
                //   icon: Icon(Icons.sync),
                //   label: Text(S.of(context).simulateTransition),
                //   style: ElevatedButton.styleFrom(
                //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                //   ),
                
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
