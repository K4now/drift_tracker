import 'package:flutter/material.dart';

class EditableInfoCard extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final TextInputType inputType;

  const EditableInfoCard({
    Key? key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.inputType = TextInputType.text,
  }) : super(key: key);

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
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
                border: UnderlineInputBorder(),
              ),
              keyboardType: inputType,
            ),
          ],
        ),
      ),
    );
  }
}
