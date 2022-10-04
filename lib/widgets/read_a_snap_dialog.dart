import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snapcup/bloc/bloc.dart';

class ReadASnapDialog extends StatelessWidget {
  final String message;
  final Uint8List imageBytes;

  const ReadASnapDialog(
      {required this.message, required this.imageBytes, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            //snap image goes here!
            Text(
              message,
            ),
            Image.memory(
              imageBytes,
              width: 100,
              height: 100,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          child: const Text('Close'),
          onPressed: () {
            context.read<SnapCubit>().hideReadASnapDialog();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
