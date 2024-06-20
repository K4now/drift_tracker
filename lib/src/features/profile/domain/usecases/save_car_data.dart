import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/domain/repositories/car_repository.dart';

class SaveCarData {
  final CarRepository repository;

  SaveCarData(this.repository);

  Future<void> call(String userId, Car car) {
    return repository.saveCarData(userId, car);
  }
}
