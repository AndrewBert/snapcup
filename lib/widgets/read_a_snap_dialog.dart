import 'package:flutter/material.dart';

class ReadASnapDialog extends StatelessWidget {
  final String message;
  final String imagePath;

  const ReadASnapDialog(
      {required this.message, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            //snap image goes here!
            Text(
              message,
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
