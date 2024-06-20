import 'package:drift_tracker/generated/l10n.dart';
import 'package:flutter/material.dart';

class MeasurementCard extends StatelessWidget {
  final double points;
  final double speedKmh;
  final double angle;
  final double maxAngle;

  const MeasurementCard({
    Key? key,
    required this.points,
    required this.speedKmh,
    required this.angle,
    required this.maxAngle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${S.of(context).points}: ${points.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '${S.of(context).currentVelocity}: ${speedKmh.toStringAsFixed(2)} km/h',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '${S.of(context).currentAngle}: ${angle.toStringAsFixed(2)}°',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              '${S.of(context).maxAngle}: ${maxAngle.toStringAsFixed(2)}°',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
