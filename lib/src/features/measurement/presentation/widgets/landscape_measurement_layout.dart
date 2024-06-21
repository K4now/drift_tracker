import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/action_buttons.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/angle_indicator.dart';
import 'package:drift_tracker/src/features/measurement/presentation/widgets/measurement_card.dart';
import 'package:flutter/material.dart';

class LandscapeMeasurementLayout extends StatelessWidget {
  final double speedKmh;
  final double points;
  final double angle;
  final double maxAngle;
  final VoidCallback onSaveSession;
  final VoidCallback onCalibrate;

  const LandscapeMeasurementLayout({
    Key? key,
    required this.speedKmh,
    required this.points,
    required this.angle,
    required this.maxAngle,
    required this.onSaveSession,
    required this.onCalibrate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: MeasurementCard(points: points, speedKmh: speedKmh, angle: angle, maxAngle: maxAngle),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActionButtons(onSaveSession: onSaveSession, onCalibrate: onCalibrate),
              SizedBox(height: 160,),
              AngleIndicator(angle: angle),
            ],
          ),
        ),
      ],
    );
  }
}
