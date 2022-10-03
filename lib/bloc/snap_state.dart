part of 'snap_cubit.dart';

class SnapState {
  final List<DrawingPoints?> drawingPoints;
  final Color selectedColor;
  final bool showColorPicker;
  final Snap? selectedSnap;
  final Snap mySnap;
  final int snapCount;
  final PictureRecorder recorder;

  SnapState({
    required this.drawingPoints,
    required this.selectedColor,
    required this.mySnap,
    required this.snapCount,
    required this.recorder,
    this.selectedSnap,
    this.showColorPicker = false,
  });

  SnapState copywith({
    List<DrawingPoints?>? drawingPoints,
    Color? selectedColor,
    String? message,
    bool? showColorPicker,
    Snap? selectedSnap,
    int? snapCount,
    Snap? mySnap,
    PictureRecorder? recorder,
  }) {
    return SnapState(
      drawingPoints: drawingPoints ?? this.drawingPoints,
      selectedColor: selectedColor ?? this.selectedColor,
      showColorPicker: showColorPicker ?? this.showColorPicker,
      selectedSnap: selectedSnap ?? this.selectedSnap,
      mySnap: mySnap ?? this.mySnap,
      snapCount: snapCount ?? this.snapCount,
      recorder: recorder ?? this.recorder,
    );
  }
}

class SnapInitial extends SnapState {
  SnapInitial({int? snapCount})
      : super(
          drawingPoints: const [],
          selectedColor: Colors.red,
          showColorPicker: false,
          selectedSnap: null,
          //
          snapCount: snapCount ?? 0,
          mySnap: const Snap(id: '', message: ''),
          //dont know if this makes sense
          recorder: PictureRecorder(),
        );
}

// class SnapSubmittedSuccess extends SnapState {
//   const SnapSubmittedSuccess()
//       : super(
//           drawingPoints: const [],
//           selectedColor: Colors.red,
//         );
// }
