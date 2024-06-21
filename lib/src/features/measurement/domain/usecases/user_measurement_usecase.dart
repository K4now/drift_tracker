class UserMeasurementUseCase {
  double calculateDriftAngle(double currentAngle, double gyroZ, double deltaTime) {
    double driftAngle = currentAngle + gyroZ * deltaTime;
    if (driftAngle > 180) {
      driftAngle -= 360;
    } else if (driftAngle < -180) {
      driftAngle += 360;
    }
    return driftAngle;
  }

  double calculatePoints(double currentPoints, double speed, double driftAngle, double gyroZ, double deltaTime) {
    double speedKmh = speed * 3.6;
    double angleChangeRate = gyroZ.abs() / deltaTime;
    double points = currentPoints + (speedKmh / 10) * driftAngle.abs() * angleChangeRate;
    return points < 0 ? 0 : points;
  }

  bool shouldResetPoints(double previousAngle, double currentAngle) {
    return (previousAngle >= 0 && currentAngle < 0) || (previousAngle < 0 && currentAngle >= 0);
  }

  double calculateTransitionSharpness(double gyroZ, double deltaTime) {
    return (gyroZ / deltaTime).abs();
  }
}
