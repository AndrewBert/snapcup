import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

part 'snap.g.dart';

@JsonSerializable()
class Snap {
  final String id;
  final String message;
  final String? imageId;
  Snap({
    required this.id,
    required this.message,
    this.imageId,
  });
}
