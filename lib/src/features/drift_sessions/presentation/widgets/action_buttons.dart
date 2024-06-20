import 'package:drift_tracker/generated/l10n.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onSaveSession;
  final VoidCallback onCalibrate;

  const ActionButtons({
    Key? key,
    required this.onSaveSession,
    required this.onCalibrate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: onCalibrate,
          icon: Icon(Icons.settings_backup_restore),
          label: Text(S.of(context).calibrate),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onSaveSession,
          icon: Icon(Icons.save),
          label: Text(S.of(context).saveSession),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
        ),
      ],
    );
  }
}
