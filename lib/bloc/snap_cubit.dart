import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';

part 'snap_state.dart';

class SnapCubit extends Cubit<SnapState> {
  late final FirebaseFirestore db;
  SnapCubit() : super(const SnapInitial()) {
    //todo make sure this works
    db = FirebaseFirestore.instance;
  }

  Future<void> addDrawingPoints(
      {required Offset globalPosition, required BuildContext context}) async {
    //might be better to pass in the RenderBox instead of the context
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    //dont forget to emit the new state
    state.drawingPoints.add(DrawingPoints(
        points: renderBox.globalToLocal(globalPosition),
        paint: Paint()
          ..isAntiAlias = true
          ..color = state.selectedColor));
    //make sure to add a null element in the list at the end of drawing a line
  }

  void changeColor(Color color) {
    emit(state.copywith(selectedColor: color));
  }

  void toggleColorPicker() {
    emit(state.copywith(showColorPicker: !state.showColorPicker));
  }

  void clear() {
    emit(state.copywith(drawingPoints: []));
  }

  void undo() {
    //search from end of list (null) to the next null closest to the end of the list
    //remove the elements beween those two null values
  }

  Future<void> submitSnap() async {
    //Enhancement: Pull out storage stuff into a service

    String? uuid;

    if (state.imageData != null) {
      final storageRef = FirebaseStorage.instance.ref();
      uuid = const Uuid().v4();
      final imageRef = storageRef.child("images/$uuid");
      try {
        await imageRef.putData(state.imageData!);
      } on FirebaseException catch (e) {
        // ...
      }
    }

    final snap = <String, dynamic>{
      "message": state.message,
      "imageId": uuid,
    };
    // Add a new document with a generated ID
    await db.collection("snaps").add(snap).then((DocumentReference doc) =>
        debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
    // emit(const SnapSubmittedSuccess());
  }

  Future<void> pickSnap() async {
    await db.collection("snaps").get().then(
      (res) {
        debugPrint("Successfully got snaps");
        res.docs.shuffle();
        final randomSnapDoc = res.docs[0];
        // var snap = Snap.fromJson(randomSnapDoc);
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}
