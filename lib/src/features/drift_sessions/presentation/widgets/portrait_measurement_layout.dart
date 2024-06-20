import 'package:drift_tracker/src/features/drift_sessions/presentation/pages/user_mensure_page.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/action_buttons.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/angle_indicator.dart';
import 'package:drift_tracker/src/features/drift_sessions/presentation/widgets/measurement_card.dart';
import 'package:flutter/material.dart';

class PortraitMeasurementLayout extends StatelessWidget {
  final double speedKmh;
  final double points;
  final double angle;
  final double maxAngle;
  final VoidCallback onSaveSession;
  final VoidCallback onCalibrate;

  const PortraitMeasurementLayout({
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MeasurementCard(points: points, speedKmh: speedKmh, angle: angle, maxAngle: maxAngle),
        SizedBox(height: 20),
        ActionButtons(onSaveSession: onSaveSession, onCalibrate: onCalibrate),
        SizedBox(height: 160,),
        AngleIndicator(angle: angle),
      ],
    );
  }
}
