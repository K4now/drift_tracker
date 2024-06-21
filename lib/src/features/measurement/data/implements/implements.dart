class UserMeasurementRepositoryImpl implements UserMeasurementRepository {
  @override
  Stream<UserMeasurement> getUserMeasurements() {
    // Реализация получения данных
    // Например, использовать Geolocator и sensors_plus для потоков данных
  }

  @override
  Future<void> saveSession(UserMeasurement session) async {
    // Реализация сохранения сессии
    // Например, сохранять в Firestore
  }
}