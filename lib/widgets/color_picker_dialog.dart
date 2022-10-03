import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerDialog extends StatelessWidget {
  final Color selectedColor;
  final Color Function(Color) onColorChanged;

  const ColorPickerDialog({
    Key? key,
    required this.selectedColor,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlockPicker(
            pickerColor: selectedColor, onColorChanged: onColorChanged),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
