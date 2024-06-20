// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:drift_tracker/src/features/drift_sessions/presentation/pages/measurement_page.dart';
// import 'package:sensors_plus/sensors_plus.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:async';
// import 'mocks.mocks.dart';  // Импортируйте сгенерированные моки

// void main() {
//   group('MeasurementPage', () {
//     late MockAccelerometerEvent mockAccelerometerEvent;
//     late MockGyroscopeEvent mockGyroscopeEvent;
//     late MockPosition mockPosition;
//     late MockSensorService mockSensorService;

//     late StreamController<AccelerometerEvent> accelerometerController;
//     late StreamController<GyroscopeEvent> gyroscopeController;
//     late StreamController<Position> positionController;

//     setUp(() {
//       mockAccelerometerEvent = MockAccelerometerEvent();
//       mockGyroscopeEvent = MockGyroscopeEvent();
//       mockPosition = MockPosition();
//       mockSensorService = MockSensorService();

//       accelerometerController = StreamController<AccelerometerEvent>();
//       gyroscopeController = StreamController<GyroscopeEvent>();
//       positionController = StreamController<Position>();
      
//       // Mock the sensor streams
//       when(mockSensorService.getAccelerometerEvents()).thenAnswer((_) => accelerometerController.stream);
//       when(mockSensorService.getGyroscopeEvents()).thenAnswer((_) => gyroscopeController.stream);
//       when(mockSensorService.getPositionStream()).thenAnswer((_) => positionController.stream);
//     });

//     tearDown(() {
//       accelerometerController.close();
//       gyroscopeController.close();
//       positionController.close();
//     });

//     testWidgets('displays initial values', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: MeasurementPage(sensorService: mockSensorService)));

//       expect(find.byKey(Key('accelerometerSpeed')), findsOneWidget);
//       expect(find.byKey(Key('gpsSpeed')), findsOneWidget);
//       expect(find.byKey(Key('driftAngle')), findsOneWidget);
//     });

//     testWidgets('updates speed and angle values', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: MeasurementPage(sensorService: mockSensorService)));

//       when(mockAccelerometerEvent.x).thenReturn(1.0);
//       when(mockAccelerometerEvent.y).thenReturn(1.0);
//       when(mockAccelerometerEvent.z).thenReturn(1.0);
//       when(mockGyroscopeEvent.z).thenReturn(1.5);
//       when(mockPosition.speed).thenReturn(10.0);

//       // Simulate sensor events
//       accelerometerController.add(mockAccelerometerEvent);
//       gyroscopeController.add(mockGyroscopeEvent);
//       positionController.add(mockPosition);

//       await tester.pumpAndSettle();

//       expect(find.text('Speed from Accelerometer: 3.00 m/s'), findsOneWidget);
//       expect(find.text('Speed from GPS: 10.00 m/s'), findsOneWidget);
//       expect(find.text('Angle: 1.50 degrees'), findsOneWidget);
//     });

//     testWidgets('saves session', (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(home: MeasurementPage(sensorService: mockSensorService)));

//       await tester.tap(find.text('Save Session'));
//       await tester.pumpAndSettle();

//       expect(find.byType(SnackBar), findsOneWidget);
//     });
//   });
// }
