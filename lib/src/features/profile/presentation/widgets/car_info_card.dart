import 'package:flutter/material.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import 'package:drift_tracker/generated/l10n.dart';

class CarInfoCard extends StatelessWidget {
  final Car car;
  final void Function(Car car) onSave;


  CarInfoCard({required this.car, required this.onSave, });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).carDetails,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text("${S.of(context).carBrand}: ${car.brand}"),
            Text("${S.of(context).horsepower}: ${car.horsepower}"),
            Text("${S.of(context).config}: ${car.config}"),
            
          ],
        ),
      ),
    );
  }
}
