part of 'snap_cubit.dart';

class SnapState {
  final List<DrawingPoints?> drawingPoints;
  final Color selectedColor;
  final String message;
  final bool showColorPicker;
  final Uint8List? imageData;

  const SnapState({
    required this.drawingPoints,
    required this.selectedColor,
    this.message = '',
    this.showColorPicker = false,
    this.imageData,
  });

  SnapState copywith(
      {List<DrawingPoints?>? drawingPoints,
      Color? selectedColor,
      String? message,
      bool? showColorPicker}) {
    return SnapState(
      drawingPoints: drawingPoints ?? this.drawingPoints,
      selectedColor: selectedColor ?? this.selectedColor,
      message: message ?? this.message,
      showColorPicker: showColorPicker ?? this.showColorPicker,
    );
  }
}

class SnapInitial extends SnapState {
  const SnapInitial()
      : super(
            drawingPoints: const [],
            selectedColor: Colors.red,
            showColorPicker: false);
}

// class SnapSubmittedSuccess extends SnapState {
//   const SnapSubmittedSuccess()
//       : super(
//           drawingPoints: const [],
//           selectedColor: Colors.red,
//         );
// }
