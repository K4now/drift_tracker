// import 'dart:math';
// import 'package:auto_route/auto_route.dart';
// import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// @RoutePage()
// class MeasurementPage extends StatefulWidget {
//   @override
//   _MeasurementPageState createState() => _MeasurementPageState();
// }

// class _MeasurementPageState extends State<MeasurementPage> {
//   double _speedFromAccelerometer = 0.0;
//   double _speedFromGPS = 0.0;
//   double _averageSpeed = 0.0;
//   double _driftAngle = 0.0;
//   double _points = 0.0;
//   double _calibrationAngle = 0.0;
//   bool _isEmulatingDrift = false;

//   List<double> _accelerometerData = [0.0, 0.0, 0.0];
//   List<double> _gyroscopeData = [0.0, 0.0, 0.0];

//   bool _isDrifting = false;
//   double _lastGyroTime = 0.0;

//   // Kalman filter variables
//   double _kalmanSpeed = 0.0;
//   double _kalmanError = 1.0;
//   double _measurementError = 1.0;
//   double _processNoise = 0.01;

//   // Sensor subscriptions
//   late StreamSubscription _accelerometerSubscription;
//   late StreamSubscription _gyroscopeSubscription;
//   StreamSubscription<Position>? _positionSubscription;
//   Timer? _emulationTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startListening();
//   }

//   void _startListening() {
//     try {
//       _accelerometerSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
//         if (!_isEmulatingDrift) {
//           setState(() {
//             _accelerometerData = [event.x, event.y, event.z];
//             _updateDriftStatus();
//           });
//         }
//       });

//       _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
//         final double now = DateTime.now().millisecondsSinceEpoch.toDouble();
//         final double deltaTime = (now - _lastGyroTime) / 1000.0;
//         _lastGyroTime = now;

//         if (!_isEmulatingDrift) {
//           setState(() {
//             _gyroscopeData = [event.x, event.y, event.z];
//             _calculateDriftAngle(event.z, deltaTime);
//           });
//         }
//       });

//       _checkLocationPermission();
//     } catch (e) {
//       _showError('Error initializing sensors: $e');
//     }
//   }

//   void _updateDriftStatus() {
//     double x = _accelerometerData[0];
//     double y = _accelerometerData[1];
//     double z = _accelerometerData[2];
//     double magnitude = sqrt(x * x + y * y + z * z);

//     _isDrifting = magnitude > 20;
//   }

//   void _calculateDriftAngle(double gyroZ, double deltaTime) {
//     double accelAngle = atan2(_accelerometerData[1], _accelerometerData[2]) * (180 / pi);

//     setState(() {
//       _driftAngle = 0.98 * (_driftAngle + gyroZ * deltaTime) + 0.02 * (accelAngle - _calibrationAngle);
//       _accumulatePoints();
//     });
//   }

//   void _accumulatePoints() {
//     setState(() {
//       _points += _averageSpeed * _driftAngle.abs(); // Accumulate points over time
//     });
//   }

//   void _calibrate() {
//     double accelAngle = atan2(_accelerometerData[1], _accelerometerData[2]) * (180 / pi);
//     setState(() {
//       _calibrationAngle = accelAngle; // Установим угол калибровки
//       _driftAngle = 0.0;
//       _points = 0.0; // Сбрасываем очки
//     });
//   }

//   void _startEmulatingDrift() {
//     _stopEmulatingDrift();
//     _isEmulatingDrift = true;
//     _emulationTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
//       setState(() {
//         _gyroscopeData = [0.0, 0.0, 90 * sin(timer.tick / 10)]; // Увеличиваем амплитуду
//         _accelerometerData = [2 * sin(timer.tick / 10), 9.81, 2 * cos(timer.tick / 10)];

//         final double now = DateTime.now().millisecondsSinceEpoch.toDouble();
//         final double deltaTime = (now - _lastGyroTime) / 1000.0;
//         _lastGyroTime = now;

//         _calculateDriftAngle(_gyroscopeData[2], deltaTime);
//       });
//     });
//   }

//   void _stopEmulatingDrift() {
//     if (_emulationTimer != null) {
//       _emulationTimer!.cancel();
//       _emulationTimer = null;
//     }
//     _isEmulatingDrift = false;
//   }

//   Future<void> _checkLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       _showError('Location services are disabled.');
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         _showError('Location permissions are denied');
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       _showError('Location permissions are permanently denied, we cannot request permissions.');
//       return;
//     }

//     _positionSubscription = Geolocator.getPositionStream().listen((Position position) {
//       setState(() {
//         double speed = position.speed * 3.6;
//         _speedFromGPS = _applyKalmanFilter(speed);
//         _calculateAverageSpeed();
//       });
//     });
//   }

//   double _applyKalmanFilter(double measurement) {
//     double kalmanGain = _kalmanError / (_kalmanError + _measurementError);
//     _kalmanSpeed = _kalmanSpeed + kalmanGain * (measurement - _kalmanSpeed);
//     _kalmanError = (1 - kalmanGain) * _kalmanError + _processNoise;
//     return _kalmanSpeed;
//   }

//   void _calculateAverageSpeed() {
//     setState(() {
//       _averageSpeed = (_speedFromAccelerometer * 3.6 + _speedFromGPS) / 2;
//     });
//   }

//   void _stopListening() {
//     _accelerometerSubscription.cancel();
//     _gyroscopeSubscription.cancel();
//     _positionSubscription?.cancel();
//     _stopEmulatingDrift();
//   }

//   Future<void> _saveSession() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final session = Session(
//         id: UniqueKey().toString(),
//         userId: user.uid,
//         maxAngle: _driftAngle,
//         points: _points.toInt(),
//         averageSpeed: _averageSpeed,
//         timestamp: Timestamp.now(),
//       );
//       await FirebaseFirestore.instance.collection('sessions').doc(session.id).set(session.toMap());
//       _showMessage('Session saved successfully');
//     } else {
//       _showError('User not logged in.');
//     }
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   void dispose() {
//     _stopListening();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Measurement'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Speed from Accelerometer: ${(_speedFromAccelerometer * 3.6).toStringAsFixed(2)} km/h',
//               key: Key('accelerometerSpeed'),
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Speed from GPS: ${_speedFromGPS.toStringAsFixed(2)} km/h',
//               key: Key('gpsSpeed'),
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Average Speed: ${_averageSpeed.toStringAsFixed(2)} km/h',
//               key: Key('averageSpeed'),
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Drift Angle: ${_driftAngle.toStringAsFixed(2)} degrees',
//               key: Key('driftAngle'),
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Points: ${_points.toStringAsFixed(2)}',
//               key: Key('points'),
//               style: TextStyle(fontSize: 24),
//             ),
//             SizedBox(height: 40),
//             Text(
//               'Accelerometer: $_accelerometerData',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Gyroscope: $_gyroscopeData',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: _saveSession,
//               child: Text('Save Session'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               key: Key('calibrateButton'),
//               onPressed: _calibrate,
//               child: Text('Calibrate'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isEmulatingDrift ? _stopEmulatingDrift : _startEmulatingDrift,
//               child: Text(_isEmulatingDrift ? 'Stop Emulating Drift' : 'Start Emulating Drift'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
