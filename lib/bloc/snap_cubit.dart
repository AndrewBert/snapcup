import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/models.dart';

part 'snap_state.dart';

class SnapCubit extends Cubit<SnapState> {
  late final FirebaseFirestore db;
  SnapCubit() : super(SnapInitial()) {
    //todo make sure this works
    db = FirebaseFirestore.instance;
  }

  Future<void> addDrawingPoints(
      {required Offset globalPosition, required BuildContext context}) async {
    //might be better to pass in the RenderBox instead of the context
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final newPoint = (DrawingPoints(
        points: renderBox.globalToLocal(globalPosition),
        paint: Paint()
          ..isAntiAlias = true
          ..color = state.selectedColor
          ..strokeWidth = 1.0));
    emit(state.copywith(drawingPoints: [...state.drawingPoints, newPoint]));
  }

  Future<void> endStroke() async {
    emit(state.copywith(drawingPoints: [...state.drawingPoints, null]));
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
    final pointsWithoutLastElement =
        state.drawingPoints.sublist(0, state.drawingPoints.length - 1);
    final nullClosestToEndOfList = pointsWithoutLastElement.lastIndexOf(null);
    final undonePointsList =
        pointsWithoutLastElement.sublist(0, nullClosestToEndOfList);
    emit(state.copywith(drawingPoints: [...undonePointsList]));
  }

  Future<void> submitSnap() async {
    //Enhancement: Pull out storage stuff into a service

    String? uuid;

    if (state.mySnap.imageData != null) {
      final storageRef = FirebaseStorage.instance.ref();
      uuid = const Uuid().v4();
      final imageRef = storageRef.child("images/$uuid");
      try {
        await imageRef.putData(state.mySnap.imageData!);
        emit(state.copywith(snapCount: state.snapCount + 1));
      } on FirebaseException catch (e) {
        // ...
      }
    }

    // Add a new document with a generated ID
    await db.collection("snaps").add(state.mySnap.toJson()).then(
        (DocumentReference doc) =>
            debugPrint('DocumentSnapshot added with ID: ${doc.id}'));
    //upload image

    //create new recorder
    // emit(const SnapSubmittedSuccess());
    emit(SnapInitial(snapCount: state.snapCount));
  }

  Future<void> pickSnap() async {
    await db.collection("snaps").get().then(
      (res) async {
        debugPrint("Successfully got snaps");
        res.docs.shuffle();
        final randomSnapDoc = res.docs[0];
        var snap = Snap.fromJson(randomSnapDoc.data());
        if (snap.imageId != null) {
          // Create a storage reference from our app
          final storageRef = FirebaseStorage.instance.ref();
          // Create a reference with an initial file path and name
          final imageRef = storageRef.child("images/${snap.imageId}");
          final imageData = await imageRef.getData();
          snap = snap.copyWith(imageData: imageData);
        }

        emit(state.copywith(selectedSnap: snap, snapCount: res.size - 1));
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
  }
}
