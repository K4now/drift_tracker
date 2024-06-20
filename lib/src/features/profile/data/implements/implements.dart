import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/src/features/profile/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseFirestore firestore;

  CarRepositoryImpl({required this.firestore});

  @override
  Future<void> saveCarData(String userId, Car car) async {
    await firestore.collection('users').doc(userId).set({
      'brand': car.brand,
      'horsepower': car.horsepower,
      'config': car.config,
    }, SetOptions(merge: true));
  }

  @override
  Future<Car?> getCarData(String userId) async {
    DocumentSnapshot doc =
        await firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return Car(
        brand: data['brand'],
        horsepower: data['horsepower'],
        config: data['config'],
      );
    }
    return null;
  }
}
