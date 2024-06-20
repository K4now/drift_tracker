class Car {
  final String brand;
  final int horsepower;
  final String config;

  Car({required this.brand, required this.horsepower, required this.config});

  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'horsepower': horsepower,
      'config': config,
    };
  }

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      brand: map['brand'],
      horsepower: map['horsepower'],
      config: map['config'],
    );
  }
}
