// import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/angle_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// import 'package:drift_tracker/src/features/drift_sessions/domain/entities/session.dart';
// import 'package:auto_route/auto_route.dart';
// import '../../../../../generated/l10n.dart';

// @RoutePage()
// class UserMeasurementPage extends StatefulWidget {
//   @override
//   _UserMeasurementPageState createState() => _UserMeasurementPageState();
// }

// class _UserMeasurementPageState extends State<UserMeasurementPage> {
//   double _points = 0.0;
//   double _driftAngle = 0.0;
//   double _speed = 0.0;
//   double _lastGyroTime = 0.0;
//   double _angle = 0.0;
//   double _maxAngle = 0.0;

//   late StreamSubscription _gyroscopeSubscription;
//   late StreamSubscription<Position> _positionSubscription;
//   Timer? _testTimer;

//   @override
//   void initState() {
//     super.initState();
//     _startListening();
//   }

//   void _startListening() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }

//     _gyroscopeSubscription = gyroscopeEvents.listen((GyroscopeEvent event) {
//       final double now = DateTime.now().millisecondsSinceEpoch.toDouble();
//       final double deltaTime = (now - _lastGyroTime) / 1000.0;
//       _lastGyroTime = now;

//       setState(() {
//         _calculateDriftAngle(event.z, deltaTime);
//         _calculatePoints(event.z, deltaTime);
//       });
//     });

//     _positionSubscription = Geolocator.getPositionStream(
//       locationSettings: const LocationSettings(
//         accuracy: LocationAccuracy.high,
//         distanceFilter: 10,
//       ),
//     ).listen((Position position) {
//       setState(() {
//         _speed = position.speed;
//       });
//     });
//   }

//   void _calculateDriftAngle(double gyroZ, double deltaTime) {
//     double previousAngle = _driftAngle;
//     setState(() {
//       _driftAngle += gyroZ * deltaTime;
//       if (_driftAngle > 180) {
//         _driftAngle -= 360;
//       } else if (_driftAngle < -180) {
//         _driftAngle += 360;
//       }
//       if (_driftAngle.abs() > _maxAngle) {
//         _maxAngle = _driftAngle.abs();
//       }

//       if ((previousAngle >= 0 && _driftAngle < 0) ||
//           (previousAngle < 0 && _driftAngle >= 0)) {
//         double transitionSharpness = (gyroZ / deltaTime).abs();
//         _points += transitionSharpness * 50;
//       }

//       _calculateAngle();
//     });
//   }

//   void _calculateAngle() {
//     setState(() {
//       _angle = _driftAngle;
//     });
//   }

//   void _calculatePoints(double gyroZ, double deltaTime) {
//     double speedKmh = _speed * 3.6;
//     double angleChangeRate = gyroZ.abs() / deltaTime;

//     setState(() {
//       _points += (speedKmh / 10) * _driftAngle.abs() * angleChangeRate;
//       _points = _points < 0 ? 0 : _points;
//     });
//   }

//   void _calibrate() {
//     setState(() {
//       _driftAngle = 0.0;
//       _points = 0.0;
//       _maxAngle = 0.0;
//     });
//   }

//   Future<void> _saveSession() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       final session = Session(
//         id: UniqueKey().toString(),
//         userId: user.uid,
//         maxAngle: _maxAngle,
//         points: _points.toInt(),
//         averageSpeed: _speed * 3.6,
//         timestamp: Timestamp.now(),
//       );
//       await FirebaseFirestore.instance
//           .collection('sessions')
//           .doc(session.id)
//           .set(session.toMap());
//       _showMessage(S.of(context).carDataSaved);
//     } else {
//       _showError(S.of(context).fieldRequired);
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(message)));
//   }

//   void _showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(message, style: TextStyle(color: Colors.red))));
//   }

//   void _stopListening() {
//     _gyroscopeSubscription.cancel();
//     _positionSubscription.cancel();
//     _testTimer?.cancel();
//   }

//   @override
//   void dispose() {
//     _stopListening();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double speedKmh = _speed * 3.6;
//     final isPortrait =
//         MediaQuery.of(context).orientation == Orientation.portrait;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).session),
//       ),
//       body: Center(
//         child: isPortrait
//             ? PortraitMeasurementLayout(
//                 speedKmh: speedKmh,
//                 points: _points,
//                 angle: _angle,
//                 maxAngle: _maxAngle,
//                 onSaveSession: _saveSession,
//                 onCalibrate: _calibrate)
//             : LandscapeMeasurementLayout(
//                 speedKmh: speedKmh,
//                 points: _points,
//                 angle: _angle,
//                 maxAngle: _maxAngle,
//                 onSaveSession: _saveSession,
//                 onCalibrate: _calibrate),
//       ),
//     );
//   }
// }
