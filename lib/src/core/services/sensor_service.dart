import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

class SensorService {
  Stream<AccelerometerEvent> getAccelerometerEvents() => accelerometerEventStream();
  Stream<GyroscopeEvent> getGyroscopeEvents() => gyroscopeEventStream();
  Stream<Position> getPositionStream() => Geolocator.getPositionStream();
}
