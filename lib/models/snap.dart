import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'snap.g.dart';

@JsonSerializable()
class Snap {
  final String id;
  final String message;
  final String? imageId;
  @JsonKey(ignore: true)
  final Uint8List? imageData;
  const Snap({
    required this.id,
    required this.message,
    this.imageId,
    this.imageData,
  });

  factory Snap.fromJson(Map<String, dynamic> json) => _$SnapFromJson(json);

  Map<String, dynamic> toJson() => _$SnapToJson(this);

  Snap copyWith({Uint8List? imageData}) {
    return Snap(
        id: id,
        message: message,
        imageId: imageId,
        imageData: imageData ?? this.imageData);
  }

  // @override
  // List<Object?> get props => [id, message, imageId];
}
