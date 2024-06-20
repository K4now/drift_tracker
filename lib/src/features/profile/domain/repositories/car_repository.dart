import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';

abstract class CarRepository {
  Future<void> saveCarData(String userId, Car car);
  Future<Car?> getCarData(String userId);
}
