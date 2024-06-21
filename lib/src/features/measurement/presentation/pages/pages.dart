import 'package:auto_route/auto_route.dart';
import 'package:drift_tracker/src/features/measurement/presentation/widgets/landscape_measurement_layout.dart';
import 'package:drift_tracker/src/features/measurement/presentation/widgets/portrait_measurement_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../generated/l10n.dart';
import '../bloc/measurement_bloc.dart';

@RoutePage()
class UserMeasurementPage extends StatefulWidget {
  @override
  _UserMeasurementPageState createState() => _UserMeasurementPageState();
}

class _UserMeasurementPageState extends State<UserMeasurementPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MeasurementBloc>(context).add(Reset()); // Сбрасываем состояние
    BlocProvider.of<MeasurementBloc>(context).add(StartListening());
  }

  @override
  void dispose() {
    // BlocProvider.of<MeasurementBloc>(context).add(StopListening());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).session),
      ),
      body: Center(
        child: BlocConsumer<MeasurementBloc, MeasurementState>(
          listener: (context, state) {
            if (state is SessionSavedNotification) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).session_saved)),
              );
              AutoRouter.of(context).back(); // Выход с экрана
            }
          },
          builder: (context, state) {
            if (state is MeasurementDataUpdated) {
              double speedKmh = state.speed * 3.6;
              return isPortrait
                  ? PortraitMeasurementLayout(
                      speedKmh: speedKmh,
                      points: state.points,
                      angle: state.driftAngle,
                      maxAngle: state.maxAngle,
                      onSaveSession: () {
                        BlocProvider.of<MeasurementBloc>(context)
                            .add(SaveSession());
                      },
                      onCalibrate: () {
                        BlocProvider.of<MeasurementBloc>(context)
                            .add(Calibrate());
                      },
                    )
                  : LandscapeMeasurementLayout(
                      speedKmh: speedKmh,
                      points: state.points,
                      angle: state.driftAngle,
                      maxAngle: state.maxAngle,
                      onSaveSession: () {
                        BlocProvider.of<MeasurementBloc>(context)
                            .add(SaveSession());
                      },
                      onCalibrate: () {
                        BlocProvider.of<MeasurementBloc>(context)
                            .add(Calibrate());
                      },
                    );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
