part of 'snap_cubit.dart';

class SnapState {
  final List<DrawingPoints?> drawingPoints;
  final Color selectedColor;
  final double selectedStrokeWidth;
  final bool readASnapDialogIsVisible;
  final Snap? selectedSnap;
  final Snap mySnap;
  final int snapCount;
  // final PictureRecorder recorder;
  final DrawingPainter painter;

  SnapState({
    required this.drawingPoints,
    required this.selectedColor,
    required this.selectedStrokeWidth,
    required this.mySnap,
    required this.snapCount,
    // required this.recorder,
    required this.painter,
    this.selectedSnap,
    this.readASnapDialogIsVisible = false,
  });

  SnapState copywith({
    List<DrawingPoints?>? drawingPoints,
    Color? selectedColor,
    double? selectedStrokeWidth,
    String? message,
    bool? readASnapDialogIsVisible,
    Snap? selectedSnap,
    int? snapCount,
    Snap? mySnap,
    // PictureRecorder? recorder,
    DrawingPainter? painter,
  }) {
    return SnapState(
      drawingPoints: drawingPoints ?? this.drawingPoints,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedStrokeWidth: selectedStrokeWidth ?? this.selectedStrokeWidth,
      readASnapDialogIsVisible:
          readASnapDialogIsVisible ?? this.readASnapDialogIsVisible,
      selectedSnap: selectedSnap ?? this.selectedSnap,
      mySnap: mySnap ?? this.mySnap,
      snapCount: snapCount ?? this.snapCount,
      // recorder: recorder ?? this.recorder,
      painter: painter ?? this.painter,
    );
  }
}

class SnapInitial extends SnapState {
  SnapInitial(
      {int? snapCount, Color? selectedColor, double? selectedStrokeWidth})
      : super(
          drawingPoints: const [],
          selectedColor: selectedColor ?? Color(0xffff7da9),
          selectedStrokeWidth: selectedStrokeWidth ?? 4.0,
          readASnapDialogIsVisible: false,
          selectedSnap: null,
          //
          snapCount: snapCount ?? 0,
          mySnap: const Snap(id: '', message: ''),
          // recorder: PictureRecorder(),
          painter: DrawingPainter(pointsList: const []),
        );
}

// class SnapSubmittedSuccess extends SnapState {
//   const SnapSubmittedSuccess()
//       : super(
//           drawingPoints: const [],
//           selectedColor: Colors.red,
//         );
// }
