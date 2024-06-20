import 'package:flutter/material.dart';
import 'package:drift_tracker/src/features/profile/domain/entities/car.dart';
import '../widgets/editable_info_card.dart';
import 'package:drift_tracker/generated/l10n.dart';

class EditCarDialog extends StatefulWidget {
  final Car car;
  final void Function(Car car) onSave;

  EditCarDialog({required this.car, required this.onSave});

  @override
  _EditCarDialogState createState() => _EditCarDialogState();
}

class _EditCarDialogState extends State<EditCarDialog> {
  late TextEditingController _brandController;
  late TextEditingController _horsepowerController;
  late TextEditingController _configController;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.car.brand);
    _horsepowerController = TextEditingController(text: widget.car.horsepower.toString());
    _configController = TextEditingController(text: widget.car.config);
  }

  @override
  void dispose() {
    _brandController.dispose();
    _horsepowerController.dispose();
    _configController.dispose();
    super.dispose();
  }

  void _saveCarData() {
    final updatedCar = Car(
      brand: _brandController.text,
      horsepower: int.parse(_horsepowerController.text),
      config: _configController.text,
    );
    widget.onSave(updatedCar);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).editCarDetails,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              EditableInfoCard(
                title: S.of(context).carBrand,
                controller: _brandController,
                hintText: S.of(context).enterCarBrand,
              ),
              EditableInfoCard(
                title: S.of(context).horsepower,
                controller: _horsepowerController,
                hintText: S.of(context).enterHorsepower,
                inputType: TextInputType.number,
              ),
              EditableInfoCard(
                title: S.of(context).config,
                controller: _configController,
                hintText: S.of(context).enterConfig,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveCarData,
                    child: Text(S.of(context).save),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
