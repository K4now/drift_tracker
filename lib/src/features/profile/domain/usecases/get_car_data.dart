import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/domain/repositories/car_repository.dart';

class GetCarData {
  final CarRepository repository;

  GetCarData(this.repository);

  Future<Car?> call(String userId) {
    return repository.getCarData(userId);
  }
}
